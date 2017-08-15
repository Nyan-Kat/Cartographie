DROP TABLE IF EXISTS Points, Portes, Pieces, Pieces_points, Pieces_portes,
Couloirs, Couloirs_points, Couloirs_portes, Carrefours, Carrefours_portes,
Obstacles, Obstacles_points, Murs, Points_calcules, Donnees_capteurs;


CREATE TABLE Points (
    ID SERIAL PRIMARY KEY,
    coordonnee_x DECIMAL(5,2) NOT NULL DEFAULT 0,
    coordonnee_y DECIMAL(5,2) NOT NULL DEFAULT 0
);


CREATE TABLE Portes (
    ID SERIAL PRIMARY KEY,
    ID_point1 INTEGER REFERENCES Points(ID),
    ID_point2 INTEGER REFERENCES Points(ID),
	isLenghtGood BOOLEAN DEFAULT False
);


CREATE TABLE Pieces (
    ID SERIAL PRIMARY KEY,
    possede_obstacle BOOLEAN,
	ajoute BOOLEAN DEFAULT false
);

CREATE TABLE Pieces_points (
	ID_piece INTEGER REFERENCES Pieces(ID),
	ID_point INTEGER REFERENCES Points(ID),
	indice INTEGER
);

CREATE TABLE Pieces_portes (
	ID_piece INTEGER REFERENCES Pieces(ID),
	ID_porte INTEGER REFERENCES Portes(ID)
);


CREATE TABLE Couloirs (
    ID SERIAL PRIMARY KEY,
    largeur INTEGER,
    possede_obstacle BOOLEAN,
	ajoute BOOLEAN DEFAULT false
);

CREATE TABLE Couloirs_points (
	ID_piece INTEGER REFERENCES Pieces(ID),
	ID_point INTEGER REFERENCES Points(ID)
);

CREATE TABLE Couloirs_portes (
	ID_couloir INTEGER REFERENCES Couloirs(ID),
	ID_porte INTEGER REFERENCES Portes(ID)
);


CREATE TABLE Carrefours (
	ID SERIAL PRIMARY KEY,
	ajoute BOOLEAN DEFAULT false
);

CREATE TABLE Carrefours_portes (
	ID_carrefour INTEGER REFERENCES Carrefours(ID),
	ID_porte INTEGER REFERENCES Portes(ID)
);


CREATE TABLE Obstacles (
	ID SERIAL PRIMARY KEY
);

CREATE TABLE Obstacles_points (
	ID_obstacle INTEGER REFERENCES Obstacles(ID),
	ID_point INTEGER REFERENCES Points(ID)
);


-- à partir de la table Points_calcules on détermine les différents murs en ajoutant les points concernés à la table Points et à une nouvelle instance de mur
-- l'orientation est indique l'intérieur de la pièce
-- le sens de construction est donné par la direction du robot
CREATE TABLE Murs (
	ID SERIAL PRIMARY KEY,
	ID_donnee INTEGER,
	ID_point1 INTEGER REFERENCES Points(ID),
	ID_point2 INTEGER REFERENCES Points(ID)
);

-- On calcule les points correspondant aux obstacle et on les stocke dans cette table qui est vidée à chaque fois qu'on analyse une nouvelle série de données
CREATE TABLE Points_calcules (
	angle INTEGER,
	coordonnee_x DECIMAL(5,2) NOT NULL DEFAULT 0,
	coordonnee_y DECIMAL(5,2) NOT NULL DEFAULT 0
);

CREATE TABLE Donnees_capteurs
(
	ID SERIAL PRIMARY KEY,
	Times TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Pos_X DECIMAL(5,2) NOT NULL DEFAULT 0,
	Pos_Y DECIMAL(5,2) NOT NULL DEFAULT 0,
	Pos_t DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm60 DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm55 DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm50 DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm45 DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm40 DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm35 DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm30 DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm25 DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm20 DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm15 DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm10 DECIMAL(5,2) NOT NULL DEFAULT 0,
	tm5 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t0 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t5 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t10 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t15 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t20 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t25 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t30 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t35 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t40 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t45 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t50 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t55 DECIMAL(5,2) NOT NULL DEFAULT 0,
	t60 DECIMAL(5,2) NOT NULL DEFAULT 0
); 