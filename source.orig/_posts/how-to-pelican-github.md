---
layout: post
title: How to set up pelican with github-pages.
date: 2015-11-14 00:47
category: How-To
tags: github, pelican, configuration.
---
Started around 11:00 PM on 13-11-2015, after doing facebook and all the regular things to distract myself to jump on working with this. Somehow my urge to keep myself away from work susided and I started to fix this thing up. Its been a long time, and I should have fixed this quite earlier, since this is not dependent on anything, apart from my musings here. Whatever, finally migrated from wordpress to octopress to pelican, so far I am liking the theme and its layout, seems it is going to provide me a lot of space to configure it well and I have aready thought of how am I going to do it.

Someone, hacked my wordpress blog, though I was also not updating it from quite some time, wish I could have got the backup somehow, nevermind I am open to start again, the data/text are present in some 10/12 files and well here it is again. Converted my org files into md and then did the 'make html'

The steps I did.
- removed my github.io account.

- installed pelican on local machine. (pip install pelican markdown typogrify)

- go to your local blog dir and setup pelican (pelican-quickstart)

- answer default to all the default questions, ofcourse except naming your blog and if its on url, provide the URL.

- pip install ghp-import (required for importing to github pages)

- write something in your content folder inside your blog project dir. save it as '.md'. Remember to put the follwing:
```
"Title: Title Name"
"Date: Date and time in YYYY-MM-DD HH:MM format"
"Category: one category only"
"Tag: many, tags, seperated, by, comma"
```
- Save it.

- run 'make html' on the command prompt.

- or pelican content -o output -s pelicanconf.py

- this will create the html content in output folder.

- now this output folder is what we need.

- run ghp-import output

- and then push it your git repository.

```git push origin git@github.com:gitusername/gitusername.github.io.git gh-pages:master```
- check the site on gitusername.github.io

Thats it.

You are done.

You can also set post-commit hooks in the same directory.
Put the directory under git control
```
cd .git/hooks/
vi post-commit
pelican content -o output -s pelicanconf.py && ghp-import output && git push origin gh-pages:master
chmod +x post-commit
```

once you are done with your blog writing, do a git commit. This will now also save your blog to internet on to your gihub-pages.

if you realise, you haven't set your remote origin run the git remote add origin ```git@github.com:gitusername/gitusername.github.io.git```, check using ```git remote -v```

Please exceuse typos. I have just updated the blog as I am taking note. Will fix later. Its been 2 hours since I am working on this, and its time for me to go to sleep. Sweet dreams and happy blogging.
