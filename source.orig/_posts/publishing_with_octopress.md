title: "Publishing using octopress and github."
date: 2016-02-21 05:00:00 +0530
comments: true
categories: HOW TO


I am setting up a web site using github and octopress, why octopress because I am familiar with it, and the team with whom I am going to work with on this project are also well versed with octopress. This blog post is most likely going to be a session of note taking of the tasks which I performed.

We are making a website for providing training on Linux and related stuff.

Following the below outline:

- Introcution to octopress.
- Why Octopress
- How Octopress
- How Github.
- How to Deploy to github.
- How to install new themes.
search for the themes at https://github.com/imathis/octopress/wiki/3rd-Party-Octopress-Themes

I selected octopress3 theme, installation is pretty straightforward


Twitter Bootstrap 3 theme for Octopress ! Check **the demo**
http://kaworu.github.io/octostrap3 for setup instructions, customization and examples.

You can get the demo's source here: https://github.com/kAworu/octostrap3/tree/gh-pages-src

Quick install
=============

```
  % cd octopress
  % git clone https://github.com/kAworu/octostrap3 .themes/octostrap3
  % rake 'install[octostrap3]'
  % rake generate
```


- How to activate disqus plugings.

Log into Disqus, set your Site Url:, Site Name:, and Site Shortname: under your profile -> install on site. Follow the engage installation steps, here you would be providing your site username, please take a note of it, this same will be required further in octopress to configure disqus. This shortname can later also be viewed from _your site name -> edit -> basic_ and under site identity you can get these details.. Great! Now configure your _config.yml by entering your Disqus shortname after disqus_short_name: Then your Disqus comments load!


- Shall we Blog!
