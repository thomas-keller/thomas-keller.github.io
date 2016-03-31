
# coding: utf-8

# In[29]:

cd C:\Users\Thomas\Documents\exif_pics


# In[39]:

import glob


# In[78]:

fnames=glob.glob('*.jpg')


# In[46]:

from PIL import Image, ExifTags
from PIL.ExifTags import TAGS


# In[48]:

from PIL import Image, ExifTags

tag_name_to_id = dict([ (v, k) for k, v in ExifTags.TAGS.items() ])

#this code I got from http://twigstechtips.blogspot.com/2014/06/python-reading-exif-and-iptc-tags-from.htmlhttp://twigstechtips.blogspot.com/2014/06/python-reading-exif-and-iptc-tags-from.html
# These I got from reading in files and matching to http://www.exiv2.org/tags.html
# You'll have to map your own if something isn't recognised
#this is all getting real dumb and overkill, but I guess that's the point
tag_name_to_id[270] = 'ImageDescription'
tag_name_to_id[306] = 'DateTime'
tag_name_to_id[256] = 'ImageWidth'
tag_name_to_id[257] = 'ImageLength'
tag_name_to_id[258] = 'BitsPerSample'
tag_name_to_id[40962] = 'PixelXDimension'
tag_name_to_id[40963] = 'PixelYDimension'
tag_name_to_id[305] = 'Software'
tag_name_to_id[37510] = 'UserComment'
tag_name_to_id[40091] = 'XPTitle'
tag_name_to_id[40092] = 'XPComment'
tag_name_to_id[40093] = 'XPAuthor'
tag_name_to_id[40094] = 'XPKeywords'
tag_name_to_id[40095] = 'XPSubject'
tag_name_to_id[40961] = 'ColorSpace' # Bit depth
tag_name_to_id[315] = 'Artist'
tag_name_to_id[33432] = 'Copyright'


# In[50]:


def convert_exif_to_dict(exif):
    """
    This helper function converts the dictionary keys from
    IDs to strings so your code is easier to read.
    """
    data = {}

    if exif is None:
        return data

    for k,v in exif.items():
       if k in TAGS:
           data[TAGS[k]] = v
       else:
           data[k] = v

    # These fields are in UCS2/UTF-16, convert to something usable within python
    for k in ['XPTitle', 'XPComment', 'XPAuthor', 'XPKeywords', 'XPSubject']:
        if k in data:
            data[k] = data[k].decode('utf-16').rstrip('\x00')

    return data


# In[80]:

TAGS


f=fnames[-1]
im=Image.open(f)
ex_dat=convert_exif_to_dict(im._getexif())


# In[83]:

fout=open('tek_sweet_photodat.csv','w')
fout.write('filename,flength,aperature,exposure,iso\n')
for f in fnames:
    im=Image.open(f)
    ex_dat=convert_exif_to_dict(im._getexif())
    v2=ex_dat['ExposureTime']
    v3=ex_dat['FNumber']
    v4=ex_dat['FocalLength']
    v5=ex_dat['ISOSpeedRatings']
    v6=float(v2[0])/float(v2[1])
    fout.write('%s,%i,%f,%f,%i\n'%(f,float(v4[0])/v4[1],float(v3[0])/float(v3[1]),v6,v5))
fout.close()
    


# In[67]:
'''
flist=[]
for fname in fnames:
    flist.append(int(fname[4:8]))
print(min(flist))
print(max(flist))
print(sum(flist)/float(len(flist)))

'''
# In[62]:

#sum in numbers? um average distance between photos distance over time? photo days?
#something like a glob then min and max the int of the number?


# In[ ]:

#something like a glob then min and max the int of the number


# In[63]:

#fnames[0]


# In[70]:

#(1475-812)


# In[71]:

#137/663.


# In[72]:

#75/663



