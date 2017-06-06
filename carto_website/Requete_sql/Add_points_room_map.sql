SET search_path to public;
DELETE FROM map_pieces_points;
DELETE FROM map_pieces_portes;
DELETE FROM map_portes;
DELETE FROM map_points;
DELETE FROM map_pieces;
DELETE FROM map_robot;

-- Add values into points table
ALTER SEQUENCE map_points_id_seq RESTART WITH 1;
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (5,5);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (5,20);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (15,20);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (15,40);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (30,40);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (30,20);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (30,30);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (30,5);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (50,30);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (50,5);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (70,20);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (70,5);
-- Add points for door
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (20,20);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (25,20);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (30,12);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (30,10);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (50,14);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (50,12);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (60,15);
INSERT INTO map_points (coordonnee_x, coordonnee_y) VALUES (65,15);

-- Add values into pieces table
ALTER SEQUENCE map_pieces_id_seq RESTART WITH 1;
INSERT INTO map_pieces (id) VALUES (1);
INSERT INTO map_pieces (id) VALUES (2);
INSERT INTO map_pieces (id) VALUES (3);
INSERT INTO map_pieces (id) VALUES (4);

-- Add values into pieces_points table
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 1),
(SELECT ID from map_points where ID = 1),1, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 1),
(SELECT ID from map_points where ID = 2),2, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 1),
(SELECT ID from map_points where ID = 6),3, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 1),
(SELECT ID from map_points where ID = 15),4, 1);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 1),
(SELECT ID from map_points where ID = 16),5, 1);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 1),
(SELECT ID from map_points where ID = 8),6, 0);

INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 2),
(SELECT ID from map_points where ID = 3),1, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 2),
(SELECT ID from map_points where ID = 4),2, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 2),
(SELECT ID from map_points where ID = 5),3, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 2),
(SELECT ID from map_points where ID = 6),4, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 2),
(SELECT ID from map_points where ID = 14),5, 1);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 2),
(SELECT ID from map_points where ID = 13),6, 1);

INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 3),
(SELECT ID from map_points where ID = 7),1, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 3),
(SELECT ID from map_points where ID = 15),2, 1);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 3),
(SELECT ID from map_points where ID = 16),3, 1);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 3),
(SELECT ID from map_points where ID = 8),4, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 3),
(SELECT ID from map_points where ID = 10),5, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 3),
(SELECT ID from map_points where ID = 18),6, 1);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 3),
(SELECT ID from map_points where ID = 17),7, 1);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 3),
(SELECT ID from map_points where ID = 9),8, 0);

INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 4),
(SELECT ID from map_points where ID = 10),1, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 4),
(SELECT ID from map_points where ID = 18),2, 1);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 4),
(SELECT ID from map_points where ID = 17),3, 1);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 4),
(SELECT ID from map_points where ID = 9),4, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 4),
(SELECT ID from map_points where ID = 19),5, 1);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 4),
(SELECT ID from map_points where ID = 20),6, 1);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 4),
(SELECT ID from map_points where ID = 11),7, 0);
INSERT INTO map_pieces_points (id_piece, id_point, indice, type_point) VALUES (
(SELECT ID from map_pieces where ID = 4),
(SELECT ID from map_points where ID = 12),8, 0);



-- Add values for porte table
ALTER SEQUENCE map_portes_id_seq RESTART WITH 1;
INSERT INTO map_portes (id_point1, id_point2) VALUES (13,14);
INSERT INTO map_portes (id_point1, id_point2) VALUES (15,16);
INSERT INTO map_portes (id_point1, id_point2) VALUES (17,18);
INSERT INTO map_portes (id_point1, id_point2) VALUES (19,20);

-- Add values for porte table
INSERT INTO map_pieces_portes (id_piece, id_porte) VALUES (1,1);
INSERT INTO map_pieces_portes (id_piece, id_porte) VALUES (2,1);
INSERT INTO map_pieces_portes (id_piece, id_porte) VALUES (1,2);
INSERT INTO map_pieces_portes (id_piece, id_porte) VALUES (3,2);
INSERT INTO map_pieces_portes (id_piece, id_porte) VALUES (3,3);
INSERT INTO map_pieces_portes (id_piece, id_porte) VALUES (4,3);
INSERT INTO map_pieces_portes (id_piece, id_porte) VALUES (4,4);

ALTER SEQUENCE map_robot_id_seq RESTART WITH 1;
INSERT INTO map_robot (pos_x, pos_y, bat, ip) VALUES (10, 10, 28, '192.168.10.12');
INSERT INTO map_robot (pos_x, pos_y, bat, ip) VALUES (20, 15, 10, '192.168.10.13');
INSERT INTO map_robot (pos_x, pos_y, bat, ip) VALUES (50, 11, 30, '192.168.10.14');
INSERT INTO map_robot (pos_x, pos_y, bat, ip) VALUES (40, 12, 34, '192.168.10.16');
