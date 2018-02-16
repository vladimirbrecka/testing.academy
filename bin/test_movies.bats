#!/usr/bin/env bats 

 load 'libs/bats-support/load'
 load 'libs/bats-assert/load'
   
  PASSWD=akadem04
  LOGIN=akadem04
     
 _query(){
    declare QUERY=$1

   echo "$QUERY" | sqlplus -S "$LOGIN"/"$PASSWD"@chinook @ config.sql
  }


@test "1.when imported, then number of genre is 19" {
    assert_equal 19 $(_query "SELECT count(*) FROM genre;")
    }

@test "2.when imported, then genres are :Adventure, Animation, Children, Comedy, Fantasy, Romance, Drama, Action, Crime, Thriller, Horror, Mystery, Sci-Fi, Documentary, IMAX, War, Musical, Western, Film-Noir" {
    assert_equal 0 $(_query "SELECT count(*) FROM GENRE g WHERE g.name NOT IN ('Adventure', 'Animation', 'Children', 'Comedy', 'Fantasy', 'Romance', 'Drama', 'Action', 'Crime', 'Thriller', 'Horror', 'Mystery', 'Sci-Fi', 'Documentary', 'IMAX', 'War', 'Musical', 'Western', 'Film-Noir');")
    }



@test "4.when imported, then number of movie with genre Sci-Fi is 656" {
    assert_equal 656 $(_query "SELECT count(*) FROM genre g INNER JOIN movie_genre mg ON g.id=mg.genreid WHERE name= 'Sci-Fi';")
    }


@test "5.when imported, then number of movie is 6973" {
    assert_equal 6973 $(_query "SELECT count(*) FROM movie;")
    }

@test "6.when imported,then movie name has only 200 characters" {
     TITLE=$(pwgen -0 200 1)
     TITLE2=$(pwgen -0 201 1)

     HODNOTA=$(_query "select count(*) + 2 from movie;")
     _query "insert into movie (ID,TITLE,"YEAR") values (6974,'$TITLE',2015);"
     _query "INSERT INTO MOVIE (ID,TITLE,"YEAR") VALUES (6975,'$TITLE2',2015);    "
     HODNOTA2=$(_query "select count(*) from movie;")
     _query "delete from movie where id=6974;"
     assert [ $HODNOTA -ne $HODNOTA2 ]

}

@test "7.when imported, then number of movies in 1984 = 70" {
    assert_equal 70 $(_query "SELECT count(*) FROM movie WHERE YEAR='1984';")
    }

@test "8.when imported, then number of movies from 1990 and genre= Action is 23" {
    assert_equal 23 $(_query "SELECT count(*) FROM movie m INNER JOIN movie_genre mg ON m.id=mg.movieid AND YEAR = '1990' INNER JOIN GENRE g ON mg.genreid=g.id AND g.name='Action';")
    }

@test "9.when imported, then can create just year betwen 1915-2015 " {


ID=$(_query "SELECT max(id) +1  FROM movie;")
ID1=$(_query "SELECT max(id) FROM movie;" )

    _query "commit;"
    _query "SET TRANSACTION name 'yyy';" 
    _query "INSERT INTO movie (id, title, year) VALUES ('$ID', 'kde bolo tam bolo', '2016');" 
 IS=$(_query "SELECT count(*) FROM movie WHERE movie.id='$ID1' and year='2016';")
    _query "ROLLBACK;"

    assert_equal "0"  "$IS"

    }


