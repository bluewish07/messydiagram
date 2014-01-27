drop table user_table
/
create table user_schema as (select * from daneliza.public_user_information)
/
create table friends_schema as (select * from daneliza.public_are_friends)
/
create table photo_schema as (select * from daneliza.public_photo_information)
/
create table tag_schema as (select * from daneliza.public_tag_information)
/
create table event_schema as (select * from daneliza.public_event_information)
/
create sequence loc_sequence start with 1 increment by 1
/
