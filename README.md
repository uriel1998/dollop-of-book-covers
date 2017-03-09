# dollop-of-book-covers
Bash script to snatch all the covers for books in your Calibre Library and to move them to where you want them (optional resizing)


This will search your entire Calibre Library for your book covers and move them to a directory of your choice with an option to resize them to whatever size you like.

#Usage

get_book_covers.sh **SourceDirectory** **OutputDirectory** -w **number** -h **number**

All arguments are optional. The defaults for the directory (both in and out) are the directory from which the script is run.

If -w and -h are not specified, no processing is done to the images. If either -w or -h is used, *both* must be used.

Output filenames are in the format of

**OutputDirectory**/Author Name_Book Name.jpg

#Dependencies

Requires [ImageMagick](https://www.imagemagick.org/script/index.php) to resize images.


#Example of Use

##For my Nook Touch

./get_book_covers.sh /home/USER/Calibre\ Library/ /home/USER/output/ -w 600 -h 800

##For my Nexus

./get_book_covers.sh /home/USER/Calibre\ Library/ /home/USER/output/ -w 1080 -h 1920


