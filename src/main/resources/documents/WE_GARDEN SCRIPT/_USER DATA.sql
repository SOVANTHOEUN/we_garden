/* DEPARTMENT */
DELETE FROM "user".department;

INSERT INTO "user".department(id, name, first_manager, second_manager) VALUES (1, 'General Management', 0, 0);
INSERT INTO "user".department(id, name, first_manager, second_manager) VALUES (2, 'Local Business', 0, 0);
INSERT INTO "user".department(id, name, first_manager, second_manager) VALUES (3, 'Mobile R&D', 0, 0);
INSERT INTO "user".department(id, name, first_manager, second_manager) VALUES (4, 'B2B R&D', 0, 0);
INSERT INTO "user".department(id, name, first_manager, second_manager) VALUES (5, 'Scraping R&D', 0, 0);
INSERT INTO "user".department(id, name, first_manager, second_manager) VALUES (6, 'Publishing R&D', 0, 0);
INSERT INTO "user".department(id, name, first_manager, second_manager) VALUES (7, 'IT Infrastructure', 0, 0);


/* TEAM */
DELETE FROM "user".team;

INSERT INTO "user".team(id, name, department_id) VALUES (1, 'Human Resources', 1);
INSERT INTO "user".team(id, name, department_id) VALUES (2, 'Accounting', 1);
INSERT INTO "user".team(id, name, department_id) VALUES (3, 'General Affairs', 1);
INSERT INTO "user".team(id, name, department_id) VALUES (4, 'Strategic Planning', 2);
INSERT INTO "user".team(id, name, department_id) VALUES (5, 'Development', 2);
INSERT INTO "user".team(id, name, department_id) VALUES (6, 'Android', 3);
INSERT INTO "user".team(id, name, department_id) VALUES (7, 'iOS', 3);
INSERT INTO "user".team(id, name, department_id) VALUES (8, 'QA', 3);
INSERT INTO "user".team(id, name, department_id) VALUES (9, 'Bizplay B2B 1', 4);
INSERT INTO "user".team(id, name, department_id) VALUES (10, 'Bizplay B2B 2', 4);
INSERT INTO "user".team(id, name, department_id) VALUES (11, 'Bizplay Contents', 4);
INSERT INTO "user".team(id, name, department_id) VALUES (12, 'QA', 4);
INSERT INTO "user".team(id, name, department_id) VALUES (13, 'Scraping I', 5);
INSERT INTO "user".team(id, name, department_id) VALUES (14, 'Scraping II', 5);
INSERT INTO "user".team(id, name, department_id) VALUES (15, 'Global Scraping', 5);
INSERT INTO "user".team(id, name, department_id) VALUES (16, 'Web', 5);
INSERT INTO "user".team(id, name, department_id) VALUES (17, 'Global Publishing', 6);
INSERT INTO "user".team(id, name, department_id) VALUES (18, 'System & Network & Security', 7);
INSERT INTO "user".team(id, name, department_id) VALUES (19, 'DB', 7);
INSERT INTO "user".team(id, name, department_id) VALUES (20, 'ATM', 7);

/* POSITION */
INSERT INTO "user".POSITION(id, position, type) VALUES (1, 'CEO', 'Executive');
INSERT INTO "user".POSITION(id, position, type) VALUES (2, 'COO', 'Executive');
INSERT INTO "user".POSITION(id, position, type) VALUES (3, 'CTO', 'Executive');
INSERT INTO "user".POSITION(id, position, type) VALUES (4, 'Director', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (5, 'Deputy Director', 'Software Engineer');

INSERT INTO "user".POSITION(id, position, type) VALUES (6, 'General Manager', 'Non-Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (7, 'Manager II', 'Non-Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (8, 'Manager I', 'Non-Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (9, 'Assistant Manager', 'Non-Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (10, 'Officer', 'Non-Software Engineer');

INSERT INTO "user".POSITION(id, position, type) VALUES (11, 'Principle Quality Assurance Engineer', 'Non-Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (12, 'Senior Quality Assurance Engineer II', 'Non-Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (13, 'Senior Quality Assurance Engineer I', 'Non-Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (14, 'Quality Assurance Engineer II', 'Non-Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (15, 'Quality Assurance Engineer I', 'Non-Software Engineer');

INSERT INTO "user".POSITION(id, position, type) VALUES (16, 'Principle Software Engineer', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (17, 'Senior Software Engineer II', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (18, 'Senior Software Engineer I', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (19, 'Software Engineer II', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (20, 'Software Engineer I', 'Software Engineer');

INSERT INTO "user".POSITION(id, position, type) VALUES (21, 'Principle UX/UI Engineer', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (22, 'Senior UX/UI Engineer II', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (23, 'Senior UX/UI Engineer I', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (24, 'UX/UI Engineer II', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (25, 'UX/UI Engineer I', 'Software Engineer');

INSERT INTO "user".POSITION(id, position, type) VALUES (26, 'Staff', 'Support Clerk');

INSERT INTO "user".POSITION(id, position, type) VALUES (27, 'Intern', NULL);

INSERT INTO "user".POSITION(id, position, type) VALUES (28, 'Principle Publishing Engineer', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (29, 'Senior Publishing Engineer II', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (30, 'Senior Publishing Engineer I', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (31, 'Publishing Engineer II', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (32, 'Publishing Engineer I', 'Software Engineer');

INSERT INTO "user".POSITION(id, position, type) VALUES (33, 'Principle Network Engineer', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (34, 'Senior Network Engineer II', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (35, 'Senior Network Engineer I', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (36, 'Network Engineer II', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (37, 'Network Engineer I', 'Software Engineer');

INSERT INTO "user".POSITION(id, position, type) VALUES (38, 'Principle Database Engineer', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (39, 'Senior Database Engineer II', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (40, 'Senior Database Engineer I', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (41, 'Database Engineer II', 'Software Engineer');
INSERT INTO "user".POSITION(id, position, type) VALUES (42, 'Database Engineer I', 'Software Engineer');

-- 1	EXECUTIVE
-- 2	FEC
-- 3	PROBATION
/* USER */
SELECT u.en_name, position.position, team.name AS team,
  (
    SELECT en_name FROM "user".user WHERE id = u.first_manager
  ) first_manager,
  (
    SELECT en_name FROM "user".user WHERE id = u.second_manager
  ) second_manager
FROM "user".user u
INNER JOIN "user".position
  ON u.position = position.id
LEFT JOIN "user".team
  ON u.team_id = team.id
ORDER BY u.team_id, u.position, u.id;
/*==============================================================================*/
INSERT INTO "user".user(id, en_name, duty, role, position, employment_status, team_id, first_manager, second_manager)
VALUES
  (1, 'Seol Wookhwan', null, 'USER', 1, 1, NULL, NULL, NULL),
  (2, 'Heang Vanny', null, 'USER', 2, 1, NULL, 1, 1),
  (3, 'Choi Sihwan', null, 'USER', 3, 1, NULL, 1, 1),
/*==============================================================================*/

-- GENERAL MANAGEMENT (Heang Vanny & Kim Youmi)
/*==============================================================================*/
  (4, 'Kim Youmi', null, 'USER', 4, 2, NULL, 2, 1),

-- HUMAN RESOURCES
  (5, 'Dy Sovannvoleak', 'HR', 'USER', 8, 2, 1, 4, 2),

-- ACCOUNTING
  (6, 'Pum Rany', 'Accounting', 'USER', 8, 2, 2, 4, 2),
  (7, 'Sann Puthy', 'Accounting', 'USER', 8, 2, 2, 6, 4),

-- GENERAL AFFAIRS
  (8, 'Song Wonha', 'General Affairs(Korean)', 'USER', 4, 2, 3, 1, 2),
  (9, 'Chhit Phatsana', 'General Affairs', 'USER', 8, 2, 3, 4, 2),
  (10, 'Chhoun Sreyoun', 'General Affairs', 'USER', 9, 2, 3, 9, 4),
  (11, 'Min Channy', 'Cook', 'USER', 26, 2, 3, 9, 4),
  (12, 'Pech Piseth', 'Office Cleaning', 'USER', 26, 2, 3, 9, 4),
  (13, 'Heang Rotha', 'Security', 'USER', 26, 2, 3, 9, 4),
  (14, 'Chum Savry', 'General Affairs', 'USER', 26, 2, 3, 9, 4),
  (15, 'Moeun Sytha', 'Cook Assistant', 'USER', 26, 2, 3, 9, 4),
  (16, 'Ska Choch', 'Chauffeur', 'USER', 26, 2, 3, 8, 2),
/*==============================================================================*/

-- LOCAL BUSINESS (Heang Vanny & Heang Vanny)
/*==============================================================================*/
-- STRATEGIC PLANNING
  (17, 'Nhim Chanborey', 'Business Planning and Development + Design', 'USER', 24, 2, 4, 2, 1), -- 17
  (18, 'Chea Rothmonita', 'Business Planning and Development + Design', 'USER', 27, 3, 4, 17, 2),

-- DEVELOPMENT
  (19, 'Chhaeuy Chhon', 'Local Product Developing', 'USER', 18, 2, 5, 2, 3),
  (20, 'Neng Channa', 'Local Product Developing', 'USER', 18, 2, 5, 2, 3),
  (21, 'San Phath', 'Local Product Developing', 'USER', 20, 2, 5, 2, 3),
  (22, 'Ty Soksal', 'Local Product Developing', 'USER', 20, 2, 5, 2, 3),
  (23, 'Choeun Chantra', 'Local Product Developing', 'USER', 20, 2, 5, 2, 3),
  (24, 'Heng Chumeng', 'Local Product Developing', 'USER', 20, 2, 5, 2, 3),
  (25, 'Nou Phanith', 'Local Product Developing', 'USER', 20, 2, 5, 2, 3),
  (26, 'Yon Yuos', 'Local Product Developing', 'USER', 20, 2, 5, 2, 3),
/*==============================================================================*/

-- MOBILE R&D (Choi Sihwan & Heo Namsu)
/*==============================================================================*/
  (27, 'Heo Namsu', NULL, 'USER', 4, 2, NULL, 3, 1), -- 27
  (28, 'Kim Howoong', NULL, 'USER', 5, 2, NULL, 27, 3),

-- ANDROID
  (29, 'Chan Youvita', 'Android Developing', 'USER', 17, 2, 6, 28, 27), -- 29
  (30, 'Huo Chhunleng', 'Android Developing', 'USER', 18, 2, 6, 29, 28),
  (31, 'Ouch Noeurng', 'Android Developing', 'USER', 19, 2, 6, 29, 28),
  (32, 'Yen Sakary', 'Android Developing', 'USER', 19, 2, 6, 29, 28),
  (33, 'Sim Seudy', 'Android Developing', 'USER', 19, 2, 6, 29, 28),
  (34, 'Sun Malen', 'Android Developing', 'USER', 20, 2, 6, 29, 28),
  (35, 'Seng Vipha', 'Android Developing', 'USER', 20, 2, 6, 29, 28),
  (36, 'Yon Serey', 'Android Developing', 'USER', 20, 2, 6, 29, 28),
  (37, 'Hor Chanpheng', 'Android Developing', 'USER', 20, 2, 6, 29, 28),
  (38, 'Ret Sokheang', 'Android Developing', 'USER', 20, 2, 6, 29, 28),
  (39, 'Tha Mariya', 'Android Developing', 'USER', 20, 2, 6, 29, 28),

-- iOS
  (40, 'Lay Bunnavitou', 'iOS Developing', 'USER', 18, 2, 7, 28, 27), -- 40
  (41, 'Kan Vichhai', 'iOS Developing', 'USER', 18, 2, 7, 40, 28),
  (42, 'Chheng Udam', 'iOS Developing', 'USER', 19, 2, 7, 40, 28),
  (43, 'Nem Sothea', 'iOS Developing', 'USER', 19, 2, 7, 40, 28),
  (44, 'Pha Vansa', 'iOS Developing', 'USER', 19, 2, 7, 40, 28),
  (45, 'Bo Sreinin', 'iOS Developing', 'USER', 20, 2, 7, 40, 28),
  (46, 'Bros Sophealey', 'iOS Developing', 'USER', 20, 2, 7, 40, 28),
  (47, 'Long Chivoin', 'iOS Developing', 'USER', 20, 2, 7, 40, 28),
  (48, 'Ngy Sunlong', 'iOS Developing', 'USER', 20, 2, 7, 40, 28),
  (49, 'Oung Safhone', 'iOS Developing', 'USER', 20, 2, 7, 40, 28),

-- QA
  (50, 'Son Seyma', 'Quality Assurance', 'USER', 14, 2, 8, 28, 27),
/*==============================================================================*/

-- B2B R&D (Choi Sihwan & Choi Sihwan)
/*==============================================================================*/
  (51, 'Lee Chang Seok', NULL, 'USER', 5, 2, NULL, 3, 1), -- 51

-- Bizplay B2B 1
  (52, 'Chey Pisall', 'Web Developing', 'USER', 17, 2, 9, 51, 3), -- 52
  (53, 'Ke Bunramy', 'Web Developing', 'USER', 19, 2, 9, 52, 51),
  (54, 'Hone Chomroeun', 'Web Developing', 'USER', 19, 2, 9, 52, 51),
  (55, 'Thoeurn Sreymean', 'Web Developing', 'USER', 20, 2, 9, 52, 51),
  (56, 'Sim Sophearoth', 'Web Developing', 'USER', 20, 2, 9, 52, 51),
  (57, 'Meas Marina', 'Web Developing', 'USER', 20, 2, 9, 52, 51),
  (58, 'Bin Sophanith', 'Web Developing', 'USER', 27, 3, 9, 52, 51),
  (59, 'Somang Rothank', 'Web Developing', 'USER', 27, 3, 9, 52, 51),

-- Bizplay B2B 2
  (60, 'Suon Yanchhuong', 'Web Developing', 'USER', 18, 2, 10, 51, 3), -- 60
  (61, 'Sung Daravuth', 'Web Developing', 'USER', 19, 2, 10, 60, 51),
  (62, 'Vong Sovanthoeun', 'Web Developing', 'USER', 20, 2, 10, 60, 51),
  (63, 'Chao Piseth', 'Web Developing', 'USER', 20, 2, 10, 60, 51),
  (64, 'Ly Seiha', 'Web Developing', 'USER', 20, 2, 10, 60, 51),
  (65, 'Sut Lyladang', 'Web Developing', 'USER', 27, 3, 10, 60, 51),
  (66, 'Yeng Pheaktra', 'Web Developing', 'USER', 27, 3, 10, 60, 51),
  (67, 'Nek Bovoleak', 'Web Developing', 'USER', 27, 3, 10, 60, 51),

-- Bizplay Contents
  (68, 'Lay Mengly', 'Web Developing', 'USER', 18, 2, 11, 51, 3), -- 68
  (69, 'Chheang Ratha', 'Web Developing', 'USER', 18, 2, 11, 68, 51),
  (70, 'San Sonan', 'Web Developing', 'USER', 20, 2, 11, 68, 51),
  (71, 'Noem Phearak', 'Web Developing', 'USER', 20, 2, 11, 68, 51),
  (72, 'Tang Kimhong', 'Web Developing', 'USER', 20, 2, 11, 68, 51),
  (73, 'Thorn Sothuon', 'Web Developing', 'USER', 20, 2, 11, 68, 51),
  (74, 'That Thon', 'Web Developing', 'USER', 27, 3, 11, 68, 51),

-- QA
  (75, 'Rous Sothy', 'Quality Assurance', 'USER', 13, 2, 12, 51, 3),
/*==============================================================================*/

-- SCRAPING R&D (Choi Sihwan & Jang Jaesun)
/*==============================================================================*/
  (76, 'Jang Jaesun', NULL, 'USER', 4, 2, NULL, 3, 1), -- 76

-- SCRAPING I
  (77, 'Nop Chanratha', 'Korea Local Scraping', 'USER', 18, 2, 13, 76, 3), -- 77
  (78, 'Kol Chamnab', 'Korea Local Scraping', 'USER', 19, 2, 13, 77, 76),
  (79, 'Chhun Panharath', 'Korea Local Scraping', 'USER', 19, 2, 13, 77, 76),
  (80, 'Ken Vantha', 'Korea Local Scraping', 'USER', 19, 2, 13, 77, 76),

-- SCRAPING II
  (81, 'Ly Sochea', 'Korea Local Scraping', 'USER', 18, 2, 14, 76, 3), -- 81
  (82, 'Lam Arun', 'Korea Local Scraping', 'USER', 19, 2, 14, 81, 76),
  (83, 'Rours Channa', 'Korea Local Scraping', 'USER', 19, 2, 14, 81, 76),
  (84, 'Houn Hong', 'Korea Local Scraping', 'USER', 20, 2, 14, 81, 76),

-- GLOBAL SCRAPING
  (85, 'Nouv Thet', 'Global Scraping', 'USER', 18, 2, 15, 76, 3), -- 85
  (86, 'Ung Vannara', 'Global Scraping', 'USER', 18, 2, 15, 85, 76),
  (87, 'Sor Mayoura', 'Global Scraping', 'USER', 19, 2, 15, 85, 76),
  (88, 'Ren Rady', 'Global Scraping', 'USER', 27, 3, 15, 85, 76),
  (89, 'Ung Ehan', 'Global Scraping', 'USER', 27, 3, 15, 85, 76),

-- WEB
  (90, 'Long Bunna', 'VAN(Billing)', 'USER', 18, 2, 16, 76, 3), -- 90
  (91, 'Houng Borey', 'VAN(Billing)', 'USER', 19, 2, 16, 90, 76),
  (92, 'E Kosal', 'Web Developing', 'USER', 19, 2, 16, 90, 76),
-- VUTHY SOKKHY

/*==============================================================================*/

-- PUBLISHING R&D (Choi Sihwan & Park Seokhwan)
/*==============================================================================*/
  (93, 'Park Seokhwan', NULL, 'USER', 4, 2, NULL, 3, 1), -- 93

-- Global Publishing
  (94, 'Kong Tykeit', 'Publishing', 'USER', 30, 2, 17, 93, 3), -- 94
  (95, 'Chhorm Chhorvy', 'Publishing', 'USER', 31, 2, 17, 94, 93),
  (96, 'Penh Sokra', 'Publishing', 'USER', 31, 2, 17, 94, 93),
  (97, 'Neo Chanthy', 'Publishing)', 'USER', 32, 2, 17, 94, 93),
  (98, 'Nut Chanmao', 'Publishing', 'USER', 32, 2, 17, 94, 93),
/*==============================================================================*/

-- IT INFRA (Choi Sihwan & Song Wonha)
/*==============================================================================*/
  (99, 'Song Wonha', NULL, 'USER', 4, 2, NULL, 3, 1), -- 99

-- System & Network & Security
  (100, 'Yann Sopheark', 'Network Maintenance', 'USER', 36, 2, 18, 99, 3),
  (101, 'Korng Lydeth', 'Network Maintenance', 'USER', 36, 2, 18, 99, 3),

-- DB
  (102, 'Suon Pisey', 'DBA', 'USER', 41, 2, 19, 99, 3),

-- ATM
  (103, 'Heng Hap', 'Wing ATM Maintainance', 'USER', 8, 2, 20, 99, 3),
  (104, 'Kol Boran', 'Wing ATM Maintainance', 'USER', 9, 2, 20, 99, 3); -- 104
/*==============================================================================*/