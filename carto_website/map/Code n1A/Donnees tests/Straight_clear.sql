DROP TABLE IF EXISTS Donnees_capteurs;
CREATE TABLE Donnees_capteurs (
ID serial PRIMARY KEY,
Times TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
Pos_X DECIMAL(5,2) NOT NULL DEFAULT 0,
Pos_Y DECIMAL(5,2) NOT NULL DEFAULT 0,
Pos_t DECIMAL(5,2) NOT NULL DEFAULT 0
); 

INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:33', 9.33, 5.73, 8.27);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:34', 7.87, 5.51, 11.24);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:34', 9.99, 6.65, 10.86);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:34', 9.84, 7.74, 9.62);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:34', 10.66, 9.43, 8.98);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:34', 11.02, 9.39, 10.09);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:34', 10.63, 10.17, 10.38);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:34', 12.95, 13.41, 11.66);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:34', 10.53, 12.91, 9.68);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:34', 11.52, 14.98, 9.36);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:34', 10.98, 13.23, 10.2);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:35', 11.87, 16.83, 11.25);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:35', 17.53, 16.32, 9.86);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:35', 11.72, 16.79, 9.93);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:35', 14.56, 14.07, 10.52);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:35', 13.88, 21.26, 9.14);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:35', 13.63, 18.2, 11.78);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:35', 18.29, 23.07, 10.26);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:35', 17.02, 22.33, 9.94);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:35', 20.89, 22.81, 9.77);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:35', 19.01, 19.79, 9.73);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:36', 22.95, 26.94, 9.06);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:36', 18.24, 25.25, 9.8);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:36', 22.46, 28.56, 8.45);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:36', 18.41, 26.8, 10.01);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:36', 20.54, 28.13, 9.41);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:36', 18.53, 29.53, 8.88);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:36', 22.63, 33.39, 11.71);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:36', 24.06, 29.15, 10.27);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:36', 22.79, 30.02, 11.16);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:37', 18.77, 29.73, 9.02);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:37', 24.19, 36.79, 10.12);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:37', 22.31, 31.9, 9.24);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:37', 24.5, 38.65, 8.95);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:37', 21.08, 40.96, 11.08);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:37', 25.64, 32.59, 10.72);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:37', 28.87, 38.14, 9.95);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:37', 25.53, 42.36, 9.97);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:37', 25.08, 40.76, 10.25);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:37', 24.02, 42.67, 10.47);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:38', 19.9, 39.76, 10.18);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:38', 23.47, 38.01, 10.59);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:38', 23.34, 34.88, 9.06);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:38', 28.57, 49.65, 10.25);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:38', 25.85, 56.32, 10.7);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:38', 29.98, 47.43, 9.65);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:38', 22.68, 44.14, 10.89);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:38', 24.34, 38.73, 10.12);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:38', 32.75, 51.47, 10.68);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:38', 27.92, 49.04, 8.99);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:39', 29.84, 53.57, 10.03);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:39', 24.58, 50.87, 10.11);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:39', 25.73, 56.7, 10.69);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:39', 34.35, 58.16, 12.17);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:39', 30.36, 61.24, 10.22);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:39', 31.44, 52.41, 9.48);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:39', 27.14, 54.51, 8.65);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:39', 39.72, 57.91, 10.66);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:39', 22.86, 68.57, 9.45);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:40', 35.02, 70.17, 9.01);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:40', 33.75, 73.57, 11.72);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:40', 36.26, 62.36, 9.59);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:40', 31.46, 60.2, 10.06);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:40', 34.24, 66.62, 11.16);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:40', 38.2, 68.67, 10.19);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:40', 30.68, 63.5, 10.44);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:40', 32.0, 72.82, 11.3);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:40', 34.6, 73.81, 9.31);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:40', 39.74, 63.43, 11.52);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:41', 35.45, 61.95, 9.95);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:41', 37.01, 75.07, 11.27);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:41', 35.7, 64.59, 9.97);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:41', 35.12, 56.18, 8.96);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:41', 38.49, 75.13, 10.73);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:41', 37.18, 79.22, 8.39);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:41', 34.28, 82.98, 10.19);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:41', 39.42, 85.26, 9.89);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:41', 36.53, 80.34, 8.72);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:42', 36.64, 80.63, 9.63);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:42', 38.94, 94.82, 10.45);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:42', 47.21, 79.88, 8.83);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:42', 34.17, 91.44, 9.22);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:42', 44.23, 62.96, 7.43);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:42', 38.93, 91.91, 9.51);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:42', 40.9, 72.2, 9.29);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:42', 37.75, 92.85, 9.41);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:42', 40.93, 75.3, 9.68);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:42', 42.65, 80.74, 9.02);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:43', 45.28, 91.38, 11.32);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:43', 39.61, 78.66, 8.98);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:43', 39.2, 78.91, 10.79);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:43', 40.44, 73.19, 8.84);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:43', 46.79, 88.72, 9.18);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:43', 50.78, 84.83, 9.32);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:43', 40.61, 73.01, 10.33);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:43', 46.37, 93.28, 11.05);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:43', 40.41, 69.68, 8.43);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:43', 49.27, 105.4, 10.91);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:44', 40.18, 98.19, 8.73);
INSERT INTO Donnees_capteurs(Times, Pos_X, Pos_Y, Pos_t) VALUES(' 2017-05-23 01:42:44', 44.56, 109.35, 11.36);
