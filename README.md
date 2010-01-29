This plugin provides a new custom field type to Movable Type Pro users.
This new field type, called a "two dimensional select" allows one to
have a pull down menu, which when a selection is made, reveals a second
pull down menu to further narrow down the user's choice. This is perfect
for managing LARGE pull down menus for which the menu's content is
easily categorized, e.g. states within regions, cities within states,
etc. 

# Usage

1. Create a new Custom Field. 

2. Select "Drop Down Menu (2-Dimensional)" as the field's type.

3. In the Options text area that appears enter in data according to the
   following structure:

         { 
           "California" => [ "LA","San Francisco","San Diego" ],
           "Texas" => [ "Dallas","Houston","Austin" ],
           "Lousiana" => [ "New Orleans","Sliddel","Baton Rougue" ],
         }

   *For those familiar with Perl, you will recognize this is a simple hash*.

   Syntax is important here, so pay attention to placement of commas, and
   make sure all square and curly brackets are opened and closed properly.

# Screenshots

## The Edit Field Screen

<img src="http://skitch.com/byrnereese/n1494/edit-field-my-first-blog-movable-type-pro" />

## The Custom Field in Action

<img src="http://skitch.com/byrnereese/n15yd/create-entry-my-first-blog-movable-type-pro" />

# Prerequisites

* Movable Type Pro

# Installation

To install this plugin follow the instructions found here:

http://tinyurl.com/easy-plugin-install

# License

This plugin is licensed under the same terms as Perl itself.