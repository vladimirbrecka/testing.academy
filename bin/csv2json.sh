#!/usr/bin/env bash

 inputFile=~/bin/movies.csv

  
 while read -r line; do
  movieId=$(echo $line | egrep -o "^[0-9]+,")
  title=$(echo $line | egrep -o ",.+ ")
  year=$(echo $line | egrep -o "([0-9]{4})")
  genres=$(echo $line | egrep -o "Action|Comedy|Drama|Horror|Thriller|Adventure|Sci-Fi|Children|Fantasy|Animation|Romance|Mystery|Crime|War|Western|Documentary|Musical|Film-Noir"| sed 's/^\|$/"/g')  
     
    echo -e "   {
        \"ID\" : \"$movieId\",
        \"Title\" : \"$title\",
        \"Year\" : \"$year\",
        \"Genres\" : [ \n           $genres 
        ]
       }"



  done < $inputFile






