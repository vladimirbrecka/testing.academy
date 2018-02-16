#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

PASSWD=akadem04
LOGIN=akadem04


_query(){
    declare QUERY=$1

    echo "$QUERY" | sqlplus -S "$LOGIN"/"$PASSWD"@chinook @ config.sql
}

@test "when imported, then check if track_seq not exist" {

PREMENA=$(_query "SELECT track_seq.nextval FROM DUAL;")
assert_equal "ORA-02289" $(echo $PREMENA | egrep -o "ORA-02289") 
}

@test "5" {
  PREMENA=$(_query "INSERT INTO TRACK (TRACKID, NAME, ALBUMID, MEDIATYPEID, GENREID, COMPOSER, MILLISECONDS, BYTES, UNITPRICE)
  VALUES ('3504', 'kokotek', '243', '1', '1', 'Edward Van Halen, Alex Van Halen, David Lee Roth, Michael Anthony', '222222', '666666', default);" | egrep -o "ORA-01400<S-F11>")    
  assert_equal $PREMENA "ORA-01400"
}






@test "when imported, then number of track i 3503" {
    assert_equal 3503 $(_query "SELECT count(*) FROM track;")
}

@test "when imported, then number of customers i 60" {
   assert_equal 60 $(_query "SELECT count(*) FROM customer;")
}
@test "when imported, then number of album i 347 " {
   assert_equal 347  $(_query "SELECT count(*) FROM album;")
}
@test "when imported, then number of invoiceline is 2240 " {
   assert_equal 2240  $(_query "SELECT count(*) FROM invoiceline;")
}
@test "when imported, then number of invoice is 412 " {
   assert_equal 412  $(_query "SELECT count(*) FROM invoice;")
}
@test "when imported, then number of artist  is 275 " {
   assert_equal 275  $(_query "SELECT count(*) FROM artist;")
}
@test "when imported, then number of genre is 25 " {
   assert_equal 25  $(_query "SELECT count(*) FROM genre;")
}
@test "when imported, then number of mediatype is 5 " {
   assert_equal 5  $(_query "SELECT count(*) FROM mediatype;")
}
@test "when imported, then number of palylist is 18 " {
   assert_equal 18  $(_query "SELECT count(*) FROM playlist;")
}
@test "when imported, then number of employee is 8 " {
   assert_equal 8  $(_query "SELECT count(*) FROM employee;")
}
@test "when imported, then number of playlisttrack is 8715 " {
   assert_equal 8715  $(_query "SELECT count(*) FROM playlisttrack;")
}

@test "when imported, then number of heavy metal clasic tracks is 26" {
    assert_equal 26 $(_query "SELECT count(*) FROM PLAYLIST pl
                               INNER JOIN PLAYLISTTRACK plt
                               ON pl.PLAYLISTID=plt.PLAYLISTID
                               AND NAME='Heavy Metal Classic';")
}

@test "when imported, then number of mediatype is 5" {
    assert_equal 0 $(_query "SELECT count(*)
FROM MEDIATYPE
WHERE name NOT IN ('MPEG audio file', 'Protected AAC audio file', 'Protected MPEG-4 video file', 'Purchased AAC audio file', 'AAC audio file');")

}

@test "when imported, then no invoice has totoal les or equal to 0" {
    assert_equal 0 $(_query "SELECT count(*) FROM INVOICE WHERE total < 0;")
    }

@test "when imported,then  " {
    assert_equal 0 $(_query "SELECT count(*) FROM INVOICELINE WHERE UNITPRICE < 0;")
    }

@test "when imported, then country is valid" {
assert_equal 0 $(_query "SELECT count(COUNTRY) FROM CUSTOMER WHERE COUNTRY not in ('Brazil','Denmark','Ireland','Poland','United Kingdom','Chile','Norway','Austria','Germany','USA','France','Finland','Spain','India','Hungary','Australia','Canada','Belgium','Czech Republic','Sweden','Argentina','Portugal','Italy','Netherlands','Slovakia');")  
 }

@test "when imported, then name of customer is valid" {
   for ENTRY in $(_query "SELECT firstname FROM CUSTOMER;"); do
       assert_equal $ENTRY $( echo $ENTRY | egrep '(^\"[A-Z][a-z]+\"$)' )
   done
}

@test "When imported, char value should be minimal 150" {
    
  assert_equal 1 $(_query "INSERT INTO TRACK (TRACKID, NAME, ALBUMID, MEDIATYPEID, GENREID, COMPOSER, MILLISECONDS, BYTES, UNITPRICE)
     VALUES ('3504', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdcndljnldjsnslfdslnsflnfljnfsfnfljdsnasdfdnfsdfdfsffsdfaffdfscasdfcsdafcafsdafcasfcfsdsdfff', '243', '1', '1', 'Edward Van Halen, Alex Van Halen, David Lee Roth, Michael Anthony', '222222', '6666666', '0.99');
    SELECT COUNT(DISTINCT t.NAME) FROM track t
    GROUP BY t.NAME
    HAVING max(LENGTH(t.NAME))>=150;
    ROLLBACK;")
 }

@test "When imported, then if can be bytes value 0" {
  
  ID=$(_query "SELECT max(TRACKID) +1 FROM TRACK;")
  
  assert_equal 0 $(_query "SET TRANSACTION NAME 'xxx';
  _query "INSERT INTO TRACK (TRACKID, NAME, ALBUMID, MEDIATYPEID, GENREID, COMPOSER, MILLISECONDS, UNITPRICE)" VALUES ('$ID', 'kdebolotambolo', '243', '1', '1', 'Edward Van Halen, Alex Van Halen, David Lee Roth, Michael Anthony', '222222', '0.99');
 _query "SELECT COUNT(*) FROM TRACK WHERE TRACKID=$ID AND BYTES IS NULL;"
  ROLLBACK;")
 }







