SET search_path to BDD;
DELETE FROM pieces_points;
DELETE FROM pieces_portes;
DELETE FROM portes;
DELETE FROM points;
DELETE FROM pieces;



-- Add values into points table
ALTER SEQUENCE points_id_seq RESTART WITH 1;
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (10,10);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (10,20);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (15,20);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (15,40);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (30,40);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (30,20);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (30,15);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (30,10);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (50,15);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (50,10);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (70,15);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (70,10);

-- Add values into pieces table
ALTER SEQUENCE pieces_id_seq RESTART WITH 1;
INSERT INTO pieces (possede_obstacle) VALUES (false);
INSERT INTO pieces (possede_obstacle) VALUES (false);
INSERT INTO pieces (possede_obstacle) VALUES (false);
INSERT INTO pieces (possede_obstacle) VALUES (false);

-- Add values into pieces_points table
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 1),
(SELECT ID from points where ID = 1),1);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 1),
(SELECT ID from points where ID = 2),2);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 1),
(SELECT ID from points where ID = 6),3);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 1),
(SELECT ID from points where ID = 8),4);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 2),
(SELECT ID from points where ID = 3),1);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 2),
(SELECT ID from points where ID = 4),2);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 2),
(SELECT ID from points where ID = 5),3);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 2),
(SELECT ID from points where ID = 6),4);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 3),
(SELECT ID from points where ID = 7),1);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 3),
(SELECT ID from points where ID = 8),2);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 3),
(SELECT ID from points where ID = 10),3);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 3),
(SELECT ID from points where ID = 9),4);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 4),
(SELECT ID from points where ID = 10),1);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 4),
(SELECT ID from points where ID = 9),2);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 4),
(SELECT ID from points where ID = 11),3);
INSERT INTO pieces_points (id_piece, id_point, indice) VALUES (
(SELECT ID from pieces where ID = 4),
(SELECT ID from points where ID = 12),4);

-- Add points for door
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (20,20);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (25,20);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (30,12);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (30,10);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (50,14);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (50,12);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (60,15);
INSERT INTO points (coordonnee_x, coordonnee_y) VALUES (65,15);

-- Add values for porte table
ALTER SEQUENCE portes_id_seq RESTART WITH 1;
INSERT INTO portes (id_point1, id_point2) VALUES (13,14);
INSERT INTO portes (id_point1, id_point2) VALUES (15,16);
INSERT INTO portes (id_point1, id_point2) VALUES (17,18);
INSERT INTO portes (id_point1, id_point2) VALUES (19,20);

-- Add values for porte table
INSERT INTO pieces_portes (id_piece, id_porte) VALUES (1,1);
INSERT INTO pieces_portes (id_piece, id_porte) VALUES (2,1);
INSERT INTO pieces_portes (id_piece, id_porte) VALUES (1,2);
INSERT INTO pieces_portes (id_piece, id_porte) VALUES (3,2);
INSERT INTO pieces_portes (id_piece, id_porte) VALUES (3,3);
INSERT INTO pieces_portes (id_piece, id_porte) VALUES (4,3);
INSERT INTO pieces_portes (id_piece, id_porte) VALUES (4,4);
