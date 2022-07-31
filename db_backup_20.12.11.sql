BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "core_comingtreatment" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"date"	datetime NOT NULL,
	"created"	datetime NOT NULL,
	"updated"	datetime NOT NULL,
	"patient_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"date_to"	datetime,
	"title"	varchar(200),
	"description"	varchar(200),
	FOREIGN KEY("patient_id") REFERENCES "core_patient"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_user" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"email"	varchar(255) NOT NULL UNIQUE,
	"name"	varchar(255) NOT NULL,
	"is_active"	bool NOT NULL,
	"is_staff"	bool NOT NULL,
	"created"	datetime NOT NULL,
	"updated"	datetime NOT NULL,
	"image"	varchar(100)
);
CREATE TABLE IF NOT EXISTS "core_patient" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(60) NOT NULL,
	"dob"	date NOT NULL,
	"age"	integer unsigned CHECK("age">=0),
	"gender"	varchar(10) NOT NULL,
	"phone"	varchar(60),
	"email"	varchar(60) NOT NULL,
	"description"	text,
	"status"	bool NOT NULL,
	"created"	datetime NOT NULL,
	"updated"	datetime NOT NULL,
	"address_id"	integer,
	"doctor_id"	integer,
	"user_id"	integer NOT NULL,
	"date_bonding"	date,
	"image"	varchar(100),
	FOREIGN KEY("doctor_id") REFERENCES "core_doctor"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("address_id") REFERENCES "core_address"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_treatment" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"title"	varchar(90) NOT NULL,
	"has_appointment"	bool NOT NULL,
	"created"	datetime NOT NULL,
	"updated"	datetime NOT NULL,
	"appointment_id"	integer,
	"patient_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"description"	text,
	FOREIGN KEY("appointment_id") REFERENCES "core_comingtreatment"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("patient_id") REFERENCES "core_patient"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_medicalexamination" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"physical_restrictions"	varchar(200) NOT NULL,
	"diabetes"	varchar(200) NOT NULL,
	"heart_problem"	varchar(200) NOT NULL,
	"kidney_illness"	varchar(200) NOT NULL,
	"emotional_difficulties"	varchar(200) NOT NULL,
	"other_diseasses"	text,
	"created"	datetime NOT NULL,
	"updated"	datetime NOT NULL,
	"patient_id"	integer NOT NULL UNIQUE,
	"sinus_infections"	varchar(200) NOT NULL,
	FOREIGN KEY("patient_id") REFERENCES "core_patient"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_clinicalexamination" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"skeletal_class"	varchar(200) NOT NULL,
	"nasolabial_angle"	varchar(200) NOT NULL,
	"nasolabial_sulcus"	varchar(200) NOT NULL,
	"lip_competency"	varchar(200) NOT NULL,
	"face_form"	varchar(200) NOT NULL,
	"molar_class_left"	varchar(200) NOT NULL,
	"molar_class_right"	varchar(200) NOT NULL,
	"midline_upper"	varchar(200) NOT NULL,
	"midline_lower"	varchar(200) NOT NULL,
	"overjet"	varchar(60) NOT NULL,
	"tongue_size"	varchar(60) NOT NULL,
	"oral_hygiene"	varchar(200) NOT NULL,
	"treatment_plan"	text,
	"treated_arch"	varchar(200) NOT NULL,
	"bracket_system"	varchar(200) NOT NULL,
	"slot"	varchar(60) NOT NULL,
	"extraction_lower"	varchar(200) NOT NULL,
	"anchorage_upper"	varchar(200) NOT NULL,
	"created"	datetime NOT NULL,
	"updated"	datetime NOT NULL,
	"patient_id"	integer NOT NULL UNIQUE,
	"habit"	varchar(60) NOT NULL,
	"extraction_upper"	varchar(200) NOT NULL,
	FOREIGN KEY("patient_id") REFERENCES "core_patient"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_attachment" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"filename"	varchar(120) NOT NULL,
	"file"	varchar(100) NOT NULL,
	"created"	datetime NOT NULL,
	"updated"	datetime NOT NULL,
	"user_id"	integer NOT NULL,
	"patient_id"	integer NOT NULL,
	"file_type"	varchar(15),
	"page_count"	integer unsigned CHECK("page_count">=0),
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("patient_id") REFERENCES "core_patient"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_treatment_files" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"treatment_id"	integer NOT NULL,
	"attachment_id"	integer NOT NULL,
	FOREIGN KEY("treatment_id") REFERENCES "core_treatment"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("attachment_id") REFERENCES "core_attachment"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "authtoken_token" (
	"key"	varchar(40) NOT NULL,
	"created"	datetime NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("key")
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "core_timetable" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(60) NOT NULL,
	"weekdays"	varchar(56) NOT NULL,
	"start_time"	time NOT NULL,
	"end_time"	time NOT NULL,
	"description"	text,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_schedule" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"start_date"	datetime NOT NULL,
	"end_date"	datetime,
	"note"	text,
	"doctor_id"	integer NOT NULL,
	"timetable_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("doctor_id") REFERENCES "core_doctor"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("timetable_id") REFERENCES "core_timetable"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_doctor" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(60) NOT NULL,
	"degree"	varchar(60) NOT NULL,
	"dob"	date NOT NULL,
	"age"	integer unsigned CHECK("age">=0),
	"gender"	varchar(10) NOT NULL,
	"phone"	varchar(60),
	"email"	varchar(60) NOT NULL,
	"description"	text,
	"status"	bool NOT NULL,
	"address_id"	integer,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("address_id") REFERENCES "core_address"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_currentpatients" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"arrive_time"	datetime NOT NULL,
	"appointment_id"	integer NOT NULL,
	"patient_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("appointment_id") REFERENCES "core_appointment"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("patient_id") REFERENCES "core_patient"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_appointment" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"patient_id"	integer,
	"date"	date NOT NULL,
	"time"	time NOT NULL,
	"note"	text,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("patient_id") REFERENCES "core_patient"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_address" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"address_line1"	varchar(60) NOT NULL
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag">=0),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_user_user_permissions" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "core_user_groups" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "core_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(150) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL
);
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (4,'2020-11-16 10:25:00','2020-10-30 05:24:01.233517','2020-12-04 15:28:16.446920',33,1,'2020-11-16 11:25:00','Dana Ahmed','Where is my camera');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (5,'2020-11-16 10:25:00','2020-10-30 05:24:34.804783','2020-12-04 15:28:18.457705',25,1,'2020-11-16 11:25:00','Nariman Baban','Sent from Istanbul');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (6,'2020-11-15 01:49:00','2020-10-30 06:46:01.348103','2020-12-04 15:28:14.240500',32,4,'2020-11-15 02:49:00','Kamaran abaka','Anythingn useful');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (7,'2020-11-20 19:12:00','2020-10-31 13:10:12.807475','2020-12-04 15:28:23.893519',31,4,'2020-11-20 20:12:00','Rawa Jamal','For cleaning');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (8,'2020-11-06 16:14:00','2020-10-31 13:14:41.357471','2020-12-04 15:28:08.090727',21,4,'2020-11-06 17:14:00','Diar Salim','New cleaning');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (9,'2020-10-17 16:14:00','2020-10-31 13:15:10.455641','2020-12-04 15:28:01.957712',17,4,'2020-10-17 17:14:00','Azad Mina','New cleaning');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (10,'2020-11-05 16:18:00','2020-10-31 13:18:15.900248','2020-12-04 15:28:06.216006',22,4,'2020-11-05 17:18:00','Nawroz Khafaf','New appointment');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (11,'2020-11-04 16:19:00','2020-10-31 13:19:50.469538','2020-12-04 15:28:04.239710',15,4,'2020-11-04 17:19:00','Rozhgar Anwar','New appointment');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (12,'2020-11-10 14:17:58','2020-11-09 14:18:00.006780','2020-12-04 15:28:12.387036',34,4,'2020-11-10 15:17:58','Maka Khalid','Today was Daban''s birthday though');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (13,'2020-11-09 14:18:14','2020-11-09 14:18:15.425384','2020-12-04 15:28:10.477716',31,4,'2020-11-09 15:18:14','Rawa Jamal','Where is my camera');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (14,'2020-11-30 03:38:00','2020-11-21 11:35:59.904324','2020-12-04 15:28:28.800574',48,4,'2020-11-30 04:38:00','Nancy Pelosi','Canine for banine');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (15,'2020-12-10 17:00:00','2020-11-21 11:36:24.989573','2020-12-10 10:51:36.957002',45,4,'2020-12-10 18:16:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (18,'2020-11-19 02:00:00','2020-11-22 11:57:30.540720','2020-12-04 15:28:21.465772',48,4,'2020-11-19 03:00:00','Nancy Pelosi','Nothing to worry');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (19,'2020-12-11 21:10:00','2020-11-22 19:08:27.356110','2020-12-04 15:26:52.098479',33,4,'2020-12-11 22:10:00','Dana Ahmed','Nothing to show!');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (20,'2020-11-30 00:00:00','2020-11-26 19:35:20.579510','2020-12-04 15:28:26.752744',47,4,'2020-11-30 01:00:00','Lucy Mayers','YYYY-MM-DDThh:mm[:ss[.uuuuuu]][+HH:MM|-HH:MM|Z]');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (21,'2020-11-30 15:15:00','2020-11-26 19:47:12.775412','2020-12-04 15:28:33.034825',47,4,'2020-11-30 16:15:00','Lucy Mayers','this.appointment.date');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (22,'2020-12-03 16:30:00','2020-11-26 19:49:18.403938','2020-12-04 15:28:38.716601',47,4,'2020-12-03 17:30:00','Lucy Mayers','NEw appointment');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (23,'2020-11-30 04:45:00','2020-11-26 19:51:19.279936','2020-12-04 15:28:30.912566',48,4,'2020-11-30 05:45:00','Nancy Pelosi','New App from input');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (25,'2020-12-04 18:30:00','2020-11-26 19:56:40.467496','2020-12-04 15:27:09.016056',45,4,'2020-12-04 19:30:00','Ibrahim Tatlises','For Ibrahim it is special');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (26,'2020-12-06 13:00:00','2020-11-28 12:22:40.368563','2020-12-09 10:37:25.681628',41,4,'2020-12-06 14:00:00','Hamay Nergiz','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (27,'2020-12-03 14:20:00','2020-12-01 14:48:44.823421','2020-12-04 15:28:35.126745',45,4,'2020-12-03 15:20:00','Ibrahim Tatlises','tutututu');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (28,'2020-12-05 18:00:00','2020-12-02 21:11:01.151653','2020-12-06 11:12:28.599232',44,4,'2020-12-05 19:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (29,'2020-12-06 18:00:00','2020-12-03 11:55:48.043740','2020-12-06 19:25:24.759749',39,4,'2020-12-06 19:00:00','Barham Hassan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (30,'2020-11-30 23:21:00','2020-12-04 15:43:22.112365','2020-12-04 15:43:22.112365',46,4,'2020-12-01 00:21:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (31,'2020-12-01 23:29:00','2020-12-04 15:44:53.543326','2020-12-04 15:44:53.543326',47,4,'2020-12-02 00:29:00','Lucy Mayers','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (32,'2020-12-01 00:09:00','2020-12-04 15:46:45.693020','2020-12-04 15:46:45.693020',45,4,'2020-12-01 01:09:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (33,'2020-12-01 03:15:00','2020-12-04 15:48:35.620045','2020-12-06 21:00:18.230476',44,4,'2020-12-01 04:15:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (34,'2020-11-30 10:00:00','2020-12-04 15:50:13.114223','2020-12-06 20:59:30.404650',43,4,'2020-11-30 11:00:00','Angelina Jolie','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (35,'2020-12-01 04:26:00','2020-12-04 15:51:30.942898','2020-12-04 15:51:30.942898',41,4,'2020-12-01 05:26:00','Hamay Nergiz','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (36,'2020-12-05 04:46:00','2020-12-04 15:56:10.239941','2020-12-04 15:56:10.239941',41,4,'2020-12-05 05:46:00','Hamay Nergiz','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (37,'2020-12-01 11:15:00','2020-12-04 15:56:38.936074','2020-12-06 20:58:51.321561',41,4,'2020-12-01 12:15:00','Hamay Nergiz','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (38,'2020-12-02 03:19:00','2020-12-04 15:57:46.285010','2020-12-04 15:57:46.285010',39,4,'2020-12-02 04:19:00','Barham Hassan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (39,'2020-12-06 01:00:00','2020-12-04 15:59:59.371524','2020-12-07 09:30:18.743768',38,4,'2020-12-06 02:00:00','Hama Karim Khan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (40,'2020-12-02 00:40:00','2020-12-04 16:01:02.247124','2020-12-04 16:01:02.247124',43,4,'2020-12-02 01:40:00','Angelina Jolie','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (41,'2020-12-01 02:00:00','2020-12-04 16:03:42.644311','2020-12-06 21:00:20.626991',44,4,'2020-12-01 03:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (42,'2020-11-30 01:00:00','2020-12-04 16:05:47.949472','2020-12-06 21:00:09.585613',46,4,'2020-11-30 03:01:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (43,'2020-11-30 03:00:00','2020-12-04 16:12:18.249205','2020-12-06 21:00:07.642264',45,4,'2020-11-30 04:00:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (44,'2020-11-30 02:37:00','2020-12-04 16:12:24.140193','2020-12-04 16:12:24.140193',46,4,'2020-11-30 03:37:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (46,'2020-12-12 19:00:00','2020-12-04 16:16:51.559260','2020-12-10 12:29:25.222405',39,4,'2020-12-12 20:00:00','Barham Hassan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (47,'2020-12-07 22:38:00','2020-12-04 16:18:06.198399','2020-12-04 16:18:06.198399',46,4,'2020-12-07 23:38:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (48,'2020-12-09 23:36:00','2020-12-04 16:18:29.523672','2020-12-04 16:18:29.523672',47,4,'2020-12-10 00:36:00','Lucy Mayers','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (49,'2020-12-05 03:17:00','2020-12-04 16:19:32.786774','2020-12-04 16:19:32.786774',41,4,'2020-12-05 04:17:00','Hamay Nergiz','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (50,'2020-12-11 19:00:00','2020-12-04 16:19:47.355137','2020-12-10 12:29:23.911455',41,4,'2020-12-11 20:00:00','Hamay Nergiz','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (51,'2020-12-10 05:00:00','2020-12-04 16:22:04.976392','2020-12-10 10:53:07.826259',40,4,'2020-12-10 06:00:00','Michael B. Jordan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (52,'2020-12-04 23:49:00','2020-12-04 16:23:08.072526','2020-12-04 16:23:08.072526',46,4,'2020-12-05 00:49:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (53,'2020-12-05 23:54:00','2020-12-04 16:24:10.113840','2020-12-04 16:24:10.113840',43,4,'2020-12-06 00:54:00','Angelina Jolie','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (54,'2020-12-12 13:30:00','2020-12-04 16:24:24.302144','2020-12-09 20:56:03.316918',43,4,'2020-12-12 14:30:00','Angelina Jolie','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (55,'2020-12-06 15:00:00','2020-12-04 16:35:07.422986','2020-12-09 10:39:10.069849',44,4,'2020-12-06 16:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (63,'2020-12-05 03:04:00','2020-12-04 17:06:16.014777','2020-12-04 17:06:16.014777',44,4,'2020-12-05 04:04:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (64,'2020-12-05 03:00:00','2020-12-04 17:13:01.056523','2020-12-04 17:13:01.056523',46,4,'2020-12-05 04:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (65,'2020-12-05 06:16:00','2020-12-04 17:16:14.287964','2020-12-04 17:16:14.287964',43,4,'2020-12-05 07:16:00','Angelina Jolie','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (66,'2020-12-05 03:22:00','2020-12-04 17:17:14.976421','2020-12-04 17:23:48.856597',46,4,'2020-12-05 06:26:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (67,'2020-12-05 04:07:00','2020-12-04 17:19:05.477067','2020-12-04 17:19:05.477067',46,4,'2020-12-05 05:07:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (69,'2020-11-30 11:00:00','2020-12-04 17:32:13.968526','2020-12-06 20:59:27.250662',46,4,'2020-11-30 12:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (70,'2020-12-03 03:00:00','2020-12-04 17:34:32.477543','2020-12-04 17:34:32.477543',46,4,'2020-12-03 04:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (71,'2020-12-09 07:00:00','2020-12-04 17:46:01.140877','2020-12-07 09:43:29.912711',45,4,'2020-12-09 08:00:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (72,'2020-11-30 09:00:00','2020-12-04 17:51:26.644839','2020-12-06 20:59:39.192738',44,4,'2020-11-30 10:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (73,'2020-12-02 05:00:00','2020-12-04 17:51:29.749155','2020-12-04 17:51:29.749155',44,4,'2020-12-02 06:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (74,'2020-12-03 03:15:00','2020-12-04 17:51:48.651435','2020-12-04 17:51:48.651435',43,4,'2020-12-03 04:15:00','Angelina Jolie','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (75,'2020-12-10 13:00:00','2020-12-04 17:51:52.745902','2020-12-10 10:50:58.082306',44,4,'2020-12-10 14:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (76,'2020-12-03 04:00:00','2020-12-04 17:51:55.989507','2020-12-04 17:51:55.989507',44,4,'2020-12-03 05:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (77,'2020-12-04 03:45:00','2020-12-04 17:52:00.131976','2020-12-04 17:52:00.131976',45,4,'2020-12-04 04:45:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (78,'2020-12-05 10:30:00','2020-12-04 17:52:02.826712','2020-12-06 20:58:45.985632',45,4,'2020-12-05 11:30:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (79,'2020-12-03 04:00:00','2020-12-04 17:52:05.482653','2020-12-04 17:52:05.482653',45,4,'2020-12-03 05:00:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (80,'2020-12-07 17:00:00','2020-12-04 17:52:07.970572','2020-12-07 12:40:23.767587',45,4,'2020-12-07 18:00:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (81,'2020-12-02 09:15:00','2020-12-04 17:54:19.253849','2020-12-06 20:59:11.846081',46,4,'2020-12-02 10:15:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (82,'2020-12-02 11:00:00','2020-12-04 17:54:22.662300','2020-12-06 20:59:15.543338',46,4,'2020-12-02 12:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (83,'2020-11-30 06:30:00','2020-12-04 17:54:26.237071','2020-12-06 20:59:45.022829',46,4,'2020-11-30 07:30:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (84,'2020-11-30 05:00:00','2020-12-04 17:54:29.139463','2020-12-06 20:59:48.082121',46,4,'2020-11-30 06:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (85,'2020-12-08 19:00:00','2020-12-04 17:55:48.515910','2020-12-10 10:51:43.861936',44,4,'2020-12-08 20:15:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (86,'2020-12-12 06:45:00','2020-12-04 17:55:51.437486','2020-12-06 20:57:31.972885',44,4,'2020-12-12 07:45:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (89,'2020-11-30 04:00:00','2020-12-04 18:53:57.683168','2020-12-06 21:00:03.481031',44,4,'2020-11-30 05:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (90,'2020-12-04 11:00:00','2020-12-04 18:54:41.513394','2020-12-04 18:54:41.513394',40,4,'2020-12-04 12:00:00','Michael B. Jordan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (91,'2020-12-04 07:15:00','2020-12-04 18:54:49.317940','2020-12-04 18:54:49.317940',38,4,'2020-12-04 08:15:00','Hama Karim Khan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (92,'2020-12-05 01:45:00','2020-12-04 18:55:16.433495','2020-12-04 18:59:01.713945',41,4,'2020-12-05 04:00:00','Hamay Nergiz','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (93,'2020-12-07 11:00:00','2020-12-04 20:33:45.743186','2020-12-07 12:12:07.287550',38,4,'2020-12-07 12:00:00','Hama Karim Khan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (94,'2020-12-06 03:00:00','2020-12-04 20:33:53.595153','2020-12-09 10:37:52.848882',41,4,'2020-12-06 04:00:00','Hamay Nergiz','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (97,'2020-12-09 15:00:00','2020-12-05 19:26:20.295248','2020-12-07 09:40:15.822106',46,4,'2020-12-09 16:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (98,'2020-12-10 19:00:00','2020-12-05 19:38:09.613930','2020-12-10 12:29:21.423779',46,4,'2020-12-10 20:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (99,'2020-12-04 16:15:00','2020-12-05 19:45:28.284458','2020-12-06 16:18:47.610309',45,4,'2020-12-04 17:15:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (100,'2020-12-07 07:00:00','2020-12-05 19:50:38.047060','2020-12-10 12:29:32.936724',47,4,'2020-12-07 10:00:00','Lucy Mayers','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (101,'2020-12-09 11:00:00','2020-12-05 19:52:54.036353','2020-12-09 20:58:37.454848',46,4,'2020-12-09 12:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (103,'2020-12-06 11:00:00','2020-12-05 20:09:37.373544','2020-12-07 09:43:55.105505',46,4,'2020-12-06 12:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (104,'2020-12-08 01:15:00','2020-12-05 20:10:01.240644','2020-12-05 20:10:01.241642',45,4,'2020-12-08 02:15:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (105,'2020-12-06 07:00:00','2020-12-05 21:27:39.354202','2020-12-07 09:30:05.282474',48,4,'2020-12-06 08:00:00','Nancy Pelosi','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (106,'2020-12-09 13:00:00','2020-12-05 21:29:15.420419','2020-12-07 09:43:32.712918',46,4,'2020-12-09 14:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (107,'2020-12-06 05:00:00','2020-12-05 21:41:05.512206','2020-12-07 09:45:51.920304',46,4,'2020-12-06 06:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (108,'2020-12-09 17:00:00','2020-12-05 21:43:55.119952','2020-12-10 12:29:16.298780',46,4,'2020-12-09 18:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (109,'2020-12-08 05:00:00','2020-12-05 21:48:50.554270','2020-12-10 10:54:38.837910',46,4,'2020-12-08 06:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (110,'2020-12-11 13:00:00','2020-12-05 21:51:36.557406','2020-12-09 16:12:54.297070',45,4,'2020-12-11 13:30:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (111,'2020-12-11 01:00:00','2020-12-05 21:55:15.578328','2020-12-05 21:55:15.578328',47,4,'2020-12-11 02:00:00','Lucy Mayers','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (112,'2020-12-11 17:00:00','2020-12-05 21:55:30.151578','2020-12-10 10:51:26.038848',48,4,'2020-12-11 18:15:00','Nancy Pelosi','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (113,'2020-12-09 19:00:00','2020-12-05 21:55:34.461910','2020-12-10 12:29:18.356776',47,4,'2020-12-09 20:00:00','Lucy Mayers','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (114,'2020-12-08 03:00:00','2020-12-05 21:55:37.849140','2020-12-07 09:43:21.833294',46,4,'2020-12-08 04:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (116,'2020-12-05 07:15:00','2020-12-05 22:13:58.154344','2020-12-05 22:13:58.154344',44,4,'2020-12-05 08:15:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (117,'2020-12-04 12:15:00','2020-12-05 22:14:09.399197','2020-12-05 22:14:09.399197',46,4,'2020-12-04 13:15:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (118,'2020-12-12 17:00:00','2020-12-05 22:16:32.300829','2020-12-07 09:45:26.352563',44,4,'2020-12-12 18:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (120,'2020-12-13 04:45:00','2020-12-05 22:21:59.227965','2020-12-06 20:57:40.692090',44,4,'2020-12-13 05:45:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (122,'2020-12-11 09:45:00','2020-12-06 14:18:35.938134','2020-12-06 20:57:12.989413',47,4,'2020-12-11 10:45:00','Lucy Mayers','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (123,'2020-12-12 04:45:00','2020-12-06 14:18:44.587831','2020-12-06 20:57:35.497745',46,4,'2020-12-12 05:45:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (128,'2020-12-06 09:00:00','2020-12-06 16:17:41.305175','2020-12-07 09:43:53.384861',44,4,'2020-12-06 10:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (129,'2020-12-11 15:00:00','2020-12-06 16:18:51.491775','2020-12-10 10:51:20.677449',41,4,'2020-12-11 16:15:00','Hamay Nergiz','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (130,'2020-12-08 17:00:00','2020-12-06 16:19:29.781251','2020-12-09 10:38:11.974421',44,4,'2020-12-08 18:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (131,'2020-12-10 07:00:00','2020-12-06 16:20:02.837343','2020-12-10 10:53:11.942782',34,4,'2020-12-10 08:00:00','Maka Khalid','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (133,'2020-12-08 09:00:00','2020-12-06 16:22:22.808282','2020-12-09 10:37:07.569936',47,4,'2020-12-08 10:00:00','Lucy Mayers','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (134,'2020-12-11 08:00:00','2020-12-06 16:24:23.444179','2020-12-06 20:57:54.779910',38,4,'2020-12-11 09:00:00','Hama Karim Khan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (136,'2020-12-12 03:00:00','2020-12-06 19:21:53.786367','2020-12-06 20:57:38.216871',47,4,'2020-12-12 04:00:00','Lucy Mayers','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (137,'2020-12-13 07:00:00','2020-12-06 19:21:57.395747','2020-12-09 10:25:31.789399',45,4,'2020-12-13 08:30:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (138,'2020-12-01 04:15:00','2020-12-06 19:22:30.475575','2020-12-06 19:22:30.475575',45,4,'2020-12-01 05:15:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (139,'2020-12-09 05:00:00','2020-12-06 19:22:35.038326','2020-12-10 10:52:03.950849',46,4,'2020-12-09 06:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (140,'2020-12-01 09:00:00','2020-12-06 19:24:57.266748','2020-12-06 20:58:35.477765',46,4,'2020-12-01 10:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (142,'2020-12-09 09:00:00','2020-12-06 20:28:55.983848','2020-12-09 10:37:46.788212',40,4,'2020-12-09 10:00:00','Michael B. Jordan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (143,'2020-12-11 03:15:00','2020-12-06 20:29:33.702395','2020-12-06 20:57:48.370970',46,4,'2020-12-11 04:15:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (145,'2020-12-12 09:00:00','2020-12-06 20:31:04.114879','2020-12-07 09:45:22.044627',45,4,'2020-12-12 10:00:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (147,'2020-12-11 06:15:00','2020-12-06 20:33:00.712957','2020-12-06 20:57:57.102808',40,4,'2020-12-11 07:15:00','Michael B. Jordan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (154,'2020-12-07 15:00:00','2020-12-06 20:44:04.752096','2020-12-07 09:43:01.276116',44,4,'2020-12-07 16:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (157,'2020-12-08 15:00:00','2020-12-06 21:00:40.260883','2020-12-08 10:04:01.048705',41,4,'2020-12-08 16:00:00','Hamay Nergiz','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (158,'2020-12-12 14:45:00','2020-12-06 21:01:21.151041','2020-12-06 21:01:21.151041',39,4,'2020-12-12 15:45:00','Barham Hassan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (160,'2020-12-17 16:00:00','2020-12-06 22:12:50.879521','2020-12-09 10:25:24.324267',43,4,'2020-12-17 17:00:00','Angelina Jolie','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (161,'2020-12-12 11:00:00','2020-12-07 09:30:59.760772','2020-12-07 09:45:18.470366',45,4,'2020-12-12 12:00:00','Ibrahim Tatlises','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (162,'2020-12-07 03:00:00','2020-12-07 16:22:21.523180','2020-12-07 16:22:23.878536',37,4,'2020-12-07 04:00:00','Ilham Shakir','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (163,'2020-12-07 05:00:00','2020-12-07 16:22:28.794616','2020-12-07 16:22:28.794616',26,4,'2020-12-07 06:00:00','Nzar Salami','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (164,'2020-12-07 01:00:00','2020-12-07 16:22:32.882306','2020-12-07 16:22:34.878562',22,4,'2020-12-07 02:00:00','Nawroz Khafaf','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (165,'2020-12-10 01:00:00','2020-12-08 20:33:43.365943','2020-12-10 10:51:11.541275',39,4,'2020-12-10 02:15:00','Barham Hassan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (166,'2020-12-08 11:00:00','2020-12-08 21:41:16.883648','2020-12-08 21:41:16.883648',40,4,'2020-12-08 12:00:00','Michael B. Jordan','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (167,'2020-12-10 15:00:00','2020-12-09 10:22:59.114629','2020-12-10 10:51:05.071838',48,4,'2020-12-10 16:15:00','Nancy Pelosi','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (168,'2020-12-09 01:00:00','2020-12-09 19:35:49.328230','2020-12-09 19:35:49.328230',46,4,'2020-12-09 02:00:00','Qubad Talabani','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (169,'2020-12-09 03:00:00','2020-12-09 20:52:51.997500','2020-12-09 20:54:33.675633',44,4,'2020-12-09 04:00:00','Taylor Swift','');
INSERT INTO "core_comingtreatment" ("id","date","created","updated","patient_id","user_id","date_to","title","description") VALUES (170,'2020-12-10 03:00:00','2020-12-10 10:42:31.094656','2020-12-10 10:53:05.530136',46,4,'2020-12-10 04:00:00','Qubad Talabani','');
INSERT INTO "core_user" ("id","password","last_login","is_superuser","email","name","is_active","is_staff","created","updated","image") VALUES (1,'pbkdf2_sha256$216000$85PbD4xpgFUY$ZrtAU56Ej8iJI+ZLzZ50lBwA9BnACXwzwQdMeF8hHSI=','2020-10-26 17:39:12',1,'darya.ibrahim@imperialknight.com','Darya Ibrahim',1,1,'2020-10-11 16:50:52.804787','2020-11-28 15:21:50.101059','uploads/profile/1ce990cc-411e-48ef-a583-3ea4d691827c.png');
INSERT INTO "core_user" ("id","password","last_login","is_superuser","email","name","is_active","is_staff","created","updated","image") VALUES (2,'pbkdf2_sha256$216000$J39raeOTcUVD$4KG/UboSI9Y4XOluWxsP+EFwQ9RXUtszk5Kf7zHNnW0=','2020-10-17 07:10:51.583530',1,'handren.kurda@gmail.com','Handren Kurda',1,1,'2020-10-13 11:55:44.686265','2020-11-28 15:21:30.644106','uploads/profile/6e3c0634-9dd5-4197-b9f6-5e61005df5cd.png');
INSERT INTO "core_user" ("id","password","last_login","is_superuser","email","name","is_active","is_staff","created","updated","image") VALUES (4,'pbkdf2_sha256$216000$K8gkLY9Z55Tg$BqQ/4/W9K6tRm3MDAW6Pddse9qWaFa1Gr92ZRcXjVmA=','2020-12-06 11:04:58.803718',1,'root@root.com','Admin Ibrahim',1,1,'2020-10-26 17:39:56.133915','2020-11-28 15:18:09.652311','uploads/profile/fcf46751-939a-409f-b097-28aa84251bc5.png');
INSERT INTO "core_user" ("id","password","last_login","is_superuser","email","name","is_active","is_staff","created","updated","image") VALUES (5,'Darya@2018',NULL,0,'bayar.khalifa@gmail.com','Bayar Khalifa',1,0,'2020-10-27 06:54:05.609390','2020-11-28 15:19:40.283822','uploads/profile/541a5655-4e60-46f0-a474-4b508bfa09b2.png');
INSERT INTO "core_user" ("id","password","last_login","is_superuser","email","name","is_active","is_staff","created","updated","image") VALUES (6,'pbkdf2_sha256$216000$EkmbusBy76E5$NyhuWyJh8JK4EALFpm6KrE0UnYbcSSic5xe/GRTp4UQ=',NULL,0,'nsar.khalifa@gmail.com','Nsar Khalifa',1,1,'2020-10-27 06:54:58.392200','2020-11-28 15:19:23.003828','uploads/profile/273098e6-3ceb-4499-8641-b0605ea6f928.png');
INSERT INTO "core_user" ("id","password","last_login","is_superuser","email","name","is_active","is_staff","created","updated","image") VALUES (7,'pbkdf2_sha256$216000$YyDbNGXMw1j4$yWDBe6o9Smv+34sL6O5+T18Ts5jmE8hnJoGvCh41K0A=',NULL,0,'khalid.chawtany@gmail.com','Khalid Chawtani',1,1,'2020-10-27 07:31:40.254206','2020-11-28 15:19:11.885232','uploads/profile/f6b0fa35-5d18-4b54-9195-5d4bfe5c141a.png');
INSERT INTO "core_user" ("id","password","last_login","is_superuser","email","name","is_active","is_staff","created","updated","image") VALUES (9,'pbkdf2_sha256$216000$bjU84q80oznq$GMs4uxHVWo/K83tFoF8kSsoe2Hz3AL24kzz97fOy0SE=',NULL,0,'shakar.abdulqadir@loxagency.com','Shakar Abdulqadir',1,0,'2020-10-27 08:33:31.502282','2020-11-28 15:18:57.917698','uploads/profile/98a77821-93b3-4eec-8e02-a87906ddddf0.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (5,'Khalid Chawtani','2020-10-15',0,'male','07504456547','khalid.chawtany@loxagency.com','About Khalid',0,'2020-10-11 17:52:20.565431','2020-11-28 12:21:30.710017',NULL,1,1,NULL,'uploads/product/265c6810-fcd0-433d-8259-cac67aec09ba.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (9,'Rawand Najmadin','2010-11-02',10,'male','07701112323','rawand.najmadin@imperialknight.com','Who is Rawand',0,'2020-10-11 17:55:10.180999','2020-11-17 14:03:54.319854',NULL,1,1,NULL,'uploads/product/9f222efc-6cb0-4c3b-b24f-935d0e23f41a.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (15,'Rozhgar Anwar','1981-06-15',39,'male','07707739988','rozhgar.anwar@gmail.com','About Rozhgar',0,'2020-10-16 16:59:50.508860','2020-11-17 13:50:37.346724',NULL,1,1,NULL,'uploads/product/26a6738c-ac6f-49c9-b164-85bd3da92276.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (17,'Azad Mina','2020-10-21',0,'female','07701570615','azad.mina@imperialknight.com','darya',1,'2020-10-18 19:12:14.509421','2020-11-28 12:20:19.001606',NULL,1,1,NULL,'uploads/product/c1162fa9-4607-46a1-b46a-a44e04fb784c.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (21,'Diar Salim','2003-03-23',17,'male','07704505050','diar.salim@imperialknight.com','About Diar',1,'2020-10-19 12:29:25.416561','2020-11-17 13:50:12.434805',NULL,1,1,NULL,'uploads/product/7a3a2a3e-d705-4c89-a182-54a2548b76ea.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (22,'Nawroz Khafaf','2001-05-12',19,'male','07701523237','nawroz.khafaf@testemailg.com','Nawroz khafaf is a well known merchant of the country',1,'2020-10-19 12:30:13.631664','2020-11-17 13:50:07.176790',NULL,1,1,NULL,'uploads/product/25431c50-a705-4b95-b68f-2defe6dd5c88.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (25,'Nariman Baban','2001-12-21',18,'male','07701471265','nariman.baban@gmail.com','About Nariman',1,'2020-10-20 18:27:41.471623','2020-11-17 13:49:53.682503',NULL,1,1,NULL,'uploads/product/c647fddd-c18d-4df7-acee-be37a8b37d67.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (26,'Nzar Salami','1985-08-05',35,'male','07701495423','nzar.salami@tavifilm.edu.com','This describes Nzar Salami',1,'2020-10-20 19:07:58.892206','2020-11-28 12:20:55.074362',NULL,1,1,NULL,'uploads/product/df4b4563-d66c-41d7-855b-0de2f39d8e62.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (30,'Sazgar Rashid','1981-10-10',39,'male','07701926812','sazgar.rashid@gmail.com','description',1,'2020-10-29 06:27:22.375182','2020-11-17 13:49:14.296898',NULL,1,4,NULL,'uploads/product/908d365f-83d2-4b28-9cef-b45aa09d9804.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (31,'Rawa Jamal','1982-10-10',38,'male','07701926812','rawa@gmail.com','description',1,'2020-10-29 06:29:04.831253','2020-11-17 12:50:27.048449',NULL,1,4,NULL,'uploads/product/21c659db-c896-4072-aff3-90387dce964f.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (32,'Kamaran abaka','2020-10-25',0,'male','07701570615','kamaran.abaka@gmail.com','aaa',1,'2020-10-29 06:29:57.271430','2020-11-17 12:39:37.417758',NULL,1,4,NULL,'uploads/product/41363699-8d2b-484a-b1a8-8e7cbd6da292.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (33,'Dana Ahmed','2004-04-24',16,'male','07701570615','darya.ibrahim@imperialknight.com','undefined',1,'2020-10-29 06:32:04.240857','2020-11-21 10:32:45.985887',NULL,1,4,NULL,'uploads/product/abe6e807-b77e-4115-901b-7ea5f6ede236.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (34,'Maka Khalid','1988-03-22',32,'male','07701570615','darya.ibrahim@imperialknight.com','Description',1,'2020-11-07 17:05:40.644608','2020-12-02 18:43:44.416702',NULL,1,4,NULL,'uploads/profile/cef4df19-7e8f-4241-ab41-198c49a04baf.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (35,'Lionel Richie','1972-03-22',48,'male','07701570615','lio.richie@imperialknight.com','Just an artist',1,'2020-11-16 21:11:52.679295','2020-11-21 21:58:19.563242',NULL,1,4,NULL,'uploads/product/a638db1e-4780-4b16-a9fc-9a60b84ce4bc.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (36,'Sumaya Tahir','1942-03-22',78,'female','07701570615','suma.tala@imperialknight.com','Just an anonymous',1,'2020-11-16 21:22:17.407859','2020-11-16 21:42:19.740838',NULL,1,4,NULL,'uploads/product/60f752d7-6142-4e9e-9618-06c5abc7ba29.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (37,'Ilham Shakir','1952-03-22',68,'female','07701570615','ilo.shako@imperialknight.com','Just an aunt',0,'2020-11-17 09:17:52.712977','2020-11-17 14:03:59.897389',NULL,1,4,NULL,'uploads/product/6a36ca17-b51e-4ffb-8100-3a495be0de40.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (38,'Hama Karim Khan','1937-03-22',83,'male','07701570615','ilo.shako@imperialknight.com','Just an aunt',1,'2020-11-17 09:23:41.276799','2020-11-17 11:44:40.047850',NULL,1,4,NULL,'uploads/product/5307871c-bb40-4e80-9323-ee4c10c06b58.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (39,'Barham Hassan','1970-03-22',50,'male','07701570615','barham.hassan@gmail.com','Just another artist',1,'2020-11-17 09:25:37.363692','2020-11-17 09:58:24.211235',NULL,1,4,NULL,'uploads/product/e88c352f-91de-4d8c-bcf8-0902bcf5ea1a.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (40,'Michael B. Jordan','1978-03-22',42,'male','07701570615','m.b@gmail.com','Just another artist',1,'2020-11-18 18:37:16.788121','2020-11-18 20:52:18.596171',NULL,1,4,NULL,'uploads/product/10e66bc5-1613-42cb-855a-cc05260ee557.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (41,'Hamay Nergiz','2006-11-14',14,'male','07504449999','foo.bar@gmail.com','No matter what',1,'2020-11-18 19:05:26.913947','2020-11-18 19:12:00.815704',NULL,1,4,NULL,'uploads/product/d6575d7f-df81-4a9f-ae49-57aa3b647fad.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (43,'Angelina Jolie','2010-11-15',10,'female','+1 888 212 212','angelina@gmail.com','',1,'2020-11-18 19:50:23.507166','2020-11-18 20:49:49.019441',NULL,1,4,NULL,'uploads/product/c0cebe40-8afa-4a74-8955-5087d71e4582.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (44,'Taylor Swift','1996-11-19',23,'female','07701926812','taylor@gmail.com','No description',1,'2020-11-18 20:46:36.725957','2020-11-18 21:09:17.599971',NULL,1,4,NULL,'uploads/product/564154a7-6710-46e6-b5b9-a5cb0bd7277e.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (45,'Ibrahim Tatlises','2008-11-10',12,'male','07702213122','ibo.tatlises@ibo-show.tr','This is tatlises',1,'2020-11-20 08:11:43.785242','2020-11-21 09:42:16.924562',NULL,1,4,NULL,'uploads/product/0d4dad22-967b-44b1-b9ca-140f3b347259.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (46,'Qubad Talabani','2007-11-19',13,'female','093 993 4212','qubad.talabani@gui.com','This is Qubad',1,'2020-11-20 08:25:56.779708','2020-11-21 10:37:08.805276',NULL,1,4,NULL,'uploads/product/ccc42adc-a1c1-407b-8c5f-f4e79deea95a.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (47,'Lucy Mayers','2014-11-11',6,'female','07701570615','lucy.mayers@gmail.com','Lucy no Pussy',1,'2020-11-20 12:26:47.731597','2020-11-20 16:12:20.548027',NULL,1,4,NULL,'uploads/product/861091b2-2d8a-4e89-b9b0-76d9f4b00dcc.png');
INSERT INTO "core_patient" ("id","name","dob","age","gender","phone","email","description","status","created","updated","address_id","doctor_id","user_id","date_bonding","image") VALUES (48,'Nancy Pelosi','2011-11-15',9,'female','07701570614','nancy.pelosi@gmail.com','Anything',1,'2020-11-20 16:13:57.642716','2020-11-25 20:41:56.647762',NULL,1,4,NULL,'uploads/product/84b8f0c6-35a1-4ead-a42f-fc7e83916669.png');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (73,'Lower canine rebuild',1,'2020-11-03 11:49:47.679113','2020-11-24 20:27:17.309142',4,33,4,'Today was Daban''s birthday though');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (74,'End of the World',0,'2020-11-04 10:56:13.993607','2020-11-24 20:27:22.240926',NULL,33,4,'End of the World');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (75,'The addiction of sex',0,'2020-11-04 10:56:32.498464','2020-11-24 20:27:28.188276',NULL,33,4,'The addiction of sex');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (76,'Treatment',0,'2020-11-04 17:05:17.859127','2020-11-24 20:27:33.533535',NULL,32,4,'Sent from her home');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (77,'This is the first treatment',0,'2020-11-07 17:07:43.343702','2020-11-24 20:27:39.576228',NULL,34,4,'Sent from her home');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (78,'Fixed Assets',0,'2020-11-07 17:15:26.795993','2020-11-24 20:27:44.344130',NULL,34,4,'Assets to be fixes');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (79,'Braces',0,'2020-11-21 15:02:40.900094','2020-11-24 20:27:49.861457',NULL,48,4,'A dental brace is a device used to correct the alignment of teeth and bite-related problems (including underbite, overbite, etc.). Braces straighten teeth by exerting steady pressure on the teeth. Learn more about braces and other orthodontic treatments here.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (80,'Bridges and Implants',0,'2020-11-21 15:03:28.763210','2020-11-24 20:27:54.960974',NULL,48,4,'Bridges and implants are two ways to replace a missing tooth or teeth. Bridges are false teeth anchored in place by neighbouring teeth. The bridge consists of two crowns on the anchoring teeth along with the false tooth in the centre. Dental implants are artificial roots used to support replacement teeth. Learn more on our Bridges & Implants page.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (81,'Root Canals',0,'2020-11-21 15:08:28.316792','2020-11-24 20:28:01.053112',NULL,48,4,'Root canals treat diseases or absessed teeth. Once a tooth is injured, cracked or decayed, it is necessary to open the tooth and clean out the infected tissue in the centre. This space is then filled and the opening sealed. Keeping your tooth helps to prevent your other teeth from drifting out of line and causing jaw problems. Saving a natural tooth avoids having to replace it with an artificial tooth. Talk to your dentist or endodontist about any concerns or questions you may have.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (82,'Dentures',0,'2020-11-21 20:52:14.199300','2020-11-24 20:28:05.721040',NULL,46,4,'Dentures are prosthetic devices replacing lost teeth. There are two types of dentures – partial and full. Full dentures are often referred to as “false teeth”. Learn more on our Dentures page.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (83,'Gum Surgery',0,'2020-11-21 20:55:19.865129','2020-11-24 20:28:09.812587',NULL,45,4,'Periodontal or gum disease is an infection that affects the gums and jaw bone, which can lead to a loss of gum and teeth. There are two major stages — gingivitis and periodontitis. Gingivitis is the milder and reversible form; periodontal disease is often more severe. In some cases, gum surgery will be required to reverse the effect of the disease.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (84,'Root Canals',0,'2020-11-21 21:46:33.497995','2020-11-24 20:28:14.163986',NULL,41,4,'Root canals treat diseases or absessed teeth. Once a tooth is injured, cracked or decayed, it is necessary to open the tooth and clean out the infected tissue in the centre. This space is then filled and the opening sealed. Keeping your tooth helps to prevent your other teeth from drifting out of line and causing jaw problems. Saving a natural tooth avoids having to replace it with an artificial tooth. Talk to your dentist or endodontist about any concerns or questions you may have.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (85,'Root Canals',0,'2020-11-21 21:54:22.448913','2020-11-24 20:28:18.147660',NULL,35,4,'Root canals treat diseases or absessed teeth. Once a tooth is injured, cracked or decayed, it is necessary to open the tooth and clean out the infected tissue in the centre. This space is then filled and the opening sealed. Keeping your tooth helps to prevent your other teeth from drifting out of line and causing jaw problems. Saving a natural tooth avoids having to replace it with an artificial tooth. Talk to your dentist or endodontist about any concerns or questions you may have.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (86,'Braces',0,'2020-11-22 10:18:16.852498','2020-11-24 20:28:21.874001',NULL,44,4,'A dental brace is a device used to correct the alignment of teeth and bite-related problems (including underbite, overbite, etc.). Braces straighten teeth by exerting steady pressure on the teeth. Learn more about braces and other orthodontic treatments here.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (87,'Gum Surgery',0,'2020-11-26 10:44:19.830407','2020-11-26 10:44:19.830407',NULL,47,4,'Periodontal or gum disease is an infection that affects the gums and jaw bone, which can lead to a loss of gum and teeth. There are two major stages — gingivitis and periodontitis. Gingivitis is the milder and reversible form; periodontal disease is often more severe. In some cases, gum surgery will be required to reverse the effect of the disease.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (88,'Dentures',0,'2020-11-26 18:30:35.609094','2020-11-26 18:30:35.609094',NULL,46,4,'Dentures are prosthetic devices replacing lost teeth. There are two types of dentures – partial and full. Full dentures are often referred to as “false teeth”. Learn more on our Dentures page.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (89,'Oral Cancer Examination',0,'2020-11-26 18:33:07.357679','2020-11-26 18:33:07.357679',NULL,43,4,'Oral cancer starts in the cells of the mouth, tongue or throat. Oral cancer screening is usually a routine part of a dental examination. In this exam, your dentist will feel for lumps or irregular tissue changes in your neck, head, face, and inside your mouth. Your dentist will also look for sores or discolored tissue in your mouth.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (90,'Teeth Whitening',0,'2020-11-26 18:38:10.037468','2020-11-26 18:38:10.037468',NULL,45,4,'Teeth naturally darken with age, however staining may be caused by various foods and beverages such as coffee, tea and berries, some drugs such as tetracycline, smoking, or a trauma to a tooth. There are various teeth whitening options available, including in-office and at-home bleaching.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (91,'Root Canals',0,'2020-11-26 18:39:15.425399','2020-11-26 18:39:15.426403',NULL,40,4,'Root canals treat diseases or absessed teeth. Once a tooth is injured, cracked or decayed, it is necessary to open the tooth and clean out the infected tissue in the centre. This space is then filled and the opening sealed. Keeping your tooth helps to prevent your other teeth from drifting out of line and causing jaw problems. Saving a natural tooth avoids having to replace it with an artificial tooth. Talk to your dentist or endodontist about any concerns or questions you may have.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (92,'Crowns and Caps',0,'2020-11-26 18:39:46.818223','2020-11-26 18:39:46.818223',NULL,40,4,'A crown or cap is a cover that fits over a tooth that has been damaged by decay, broken, badly stained or mis-shaped. It is prepared by your dentist, and usually requires more than one visit to complete. A crown can be made of acrylic, metal, porcelain, or porcelain bonded to metal. All-porcelain crowns look more like your natural teeth, and therefore are usually used for front teeth, while porcelain bonded to metal is stronger and better for crowns in the back of the mouth. Sometimes all-metal crowns are used for back teeth because of the metal’s strength. To prepare your tooth for a crown, the tooth is first frozen with anesthesia, and then filed down so the cap can fit over it. An impression of the teeth and gums is made, and a temporary cap is fitted over the tooth until the permanent crown is ready. On your next visit, the dentist will remove the temporary cap and cement the crown onto the tooth. The crown will closely match the colour and shape of your natural teeth.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (93,'Braces',0,'2020-11-28 12:22:12.287895','2020-11-28 12:22:12.287895',NULL,47,4,'A dental brace is a device used to correct the alignment of teeth and bite-related problems (including underbite, overbite, etc.). Braces straighten teeth by exerting steady pressure on the teeth. Learn more about braces and other orthodontic treatments here.');
INSERT INTO "core_treatment" ("id","title","has_appointment","created","updated","appointment_id","patient_id","user_id","description") VALUES (94,'Fillings and Repairs',0,'2020-12-08 21:40:30.455967','2020-12-08 21:40:30.455967',NULL,39,4,'Dental fillings and repairs use restorative materials used to repair teeth which have been compromised due to cavities or trauma. More information on fillings can be found here.');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (1,'75','50','75','95','95','','2020-11-18 15:22:31.449028','2020-11-18 15:22:31.449028',39,'75');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (2,'75','50','75','95','95','','2020-11-18 18:37:16.822543','2020-11-18 18:37:16.822543',40,'75');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (3,'75','75','75','75','75','','2020-11-18 19:05:26.940795','2020-11-18 19:05:26.940795',41,'75');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (5,'75','75','75','75','75','','2020-11-18 19:50:23.562359','2020-11-18 19:50:23.563359',43,'75');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (6,'95','10','50','50','25','BAd','2020-11-18 20:46:36.764940','2020-11-18 20:46:36.764940',44,'50');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (7,'50','95','25','95','10','Worst and go','2020-11-20 08:11:43.827564','2020-11-21 09:42:16.936591',45,'75');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (8,'95','50','95','95','95','No diseasses','2020-11-20 08:25:56.824203','2020-11-21 10:37:08.817539',46,'95');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (9,'95','95','75','95','95','Excelent','2020-11-20 12:26:47.793999','2020-11-20 16:12:20.578436',47,'95');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (10,'95','50','50','75','95','No diseseasses','2020-11-20 16:13:57.678815','2020-11-25 20:41:56.683665',48,'95');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (11,'95','95','95','95','95','','2020-11-20 21:56:50.739913','2020-11-20 21:58:07.115563',26,'95');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (12,'95','95','95','95','95','','2020-11-21 10:32:45.979891','2020-11-21 10:32:45.996888',33,'95');
INSERT INTO "core_medicalexamination" ("id","physical_restrictions","diabetes","heart_problem","kidney_illness","emotional_difficulties","other_diseasses","created","updated","patient_id","sinus_infections") VALUES (13,'95','95','95','95','95','','2020-11-21 21:58:19.536516','2020-11-21 21:58:19.604320',35,'95');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (1,'class2','acute','deep','incompetent','brachycephalic','class2','class2','deviated_to_right','coincidence','Overjet','Long','good','First: do it, Second still do','max','class1','twice as much','class1','class1','2020-11-13 00:01:29.842320','2020-11-21 10:32:45.991888',33,'Not washing his teeth','class1');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (2,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Overjet','Long','good','nothing to worry','max','Perfectly well','twice as much','Nasobial','Not sure','2020-11-16 19:14:31.148786','2020-11-16 19:14:31.148786',34,'Not washing his teeth','Nasolagial');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (3,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','class1','normal','class1','class1','2020-11-16 21:39:41.143342','2020-11-21 21:58:19.585070',35,'Naughty','class1');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (4,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-16 21:39:48.896133','2020-11-16 21:39:48.896133',36,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (5,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 09:23:41.284772','2020-11-17 09:23:41.284772',38,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (6,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 09:25:37.370694','2020-11-17 09:25:37.370694',39,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (7,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 12:36:57.321546','2020-11-17 12:36:57.333546',37,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (8,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 12:39:37.412756','2020-11-17 12:39:37.425759',32,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (9,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 12:50:27.043298','2020-11-17 12:50:27.053493',31,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (10,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 13:49:14.290896','2020-11-17 13:49:14.301897',30,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (11,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','class1','normal','class1','class1','2020-11-17 13:49:47.669626','2020-11-20 21:58:07.100601',26,'Naughty','class1');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (12,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 13:49:53.677502','2020-11-17 13:49:53.688506',25,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (13,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 13:50:07.166753','2020-11-17 13:50:07.182977',22,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (14,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 13:50:12.428807','2020-11-17 13:50:12.440807',21,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (15,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 13:50:28.500534','2020-11-17 13:50:28.511595',17,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (16,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 13:50:37.340756','2020-11-17 13:50:37.351830',15,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (17,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 13:50:59.661656','2020-11-17 13:50:59.673656',9,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (18,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','steel','normal','normal','normal','2020-11-17 13:51:13.077560','2020-11-17 13:51:13.093559',5,'Naughty','normal');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (19,'class1','normal','normal','competent','dolichocephalic','class1','class1','coincidence','coincidence','Diskjet','Long','good','','max','class1','normal','class1','class1','2020-11-18 18:37:16.808700','2020-11-18 18:37:16.808700',40,'Naughty','class1');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (20,'class2','acute','normal','incompetent','mesocephalic','class2','class2','coincidence','deviated_to_left','Overjet','Long','good','No plans','max','class2','Plot','class2','class2','2020-11-18 19:05:26.928439','2020-11-18 19:05:26.928439',41,'Naughty','class1');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (22,'class1','normal','deep','competent','mesocephalic','class1','class2','deviated_to_left','coincidence','Overjet','Long','fair','No plans','max','class3','Plot','class2','class1','2020-11-18 19:50:23.539789','2020-11-18 19:50:23.540395',43,'Naughty','class2');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (23,'class2','normal','normal','incompetent','mesocephalic','class1','class2','coincidence','deviated_to_left','Overjet','Long','fair','No Plans','max','class2','Plot','class3','class3','2020-11-18 20:46:36.748374','2020-11-18 20:46:36.748374',44,'Naughty','class3');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (24,'class2','normal','normal','incompetent','mesocephalic','class1','class2','coincidence','coincidence','Overjet','Long','fair','No plan','max','class3','Plot','class2','class2','2020-11-20 08:11:43.807923','2020-11-21 09:42:16.931589',45,'Naughty','class2');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (25,'class1','normal','deep','competent','dolichocephalic','class2','class2','deviated_to_left','deviated_to_left','Overjet','Long','fair','No plan','max','class3','Plot','class2','class2','2020-11-20 08:25:56.806710','2020-11-21 10:37:08.811271',46,'Naughty','class1');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (26,'class3','normal','normal','competent','mesocephalic','class1','class3','deviated_to_left','deviated_to_left','Overjet','Short','fair','No plans','max','class3','Plot','class2','class2','2020-11-20 12:26:47.769022','2020-11-20 16:12:20.564841',47,'Naughty','class2');
INSERT INTO "core_clinicalexamination" ("id","skeletal_class","nasolabial_angle","nasolabial_sulcus","lip_competency","face_form","molar_class_left","molar_class_right","midline_upper","midline_lower","overjet","tongue_size","oral_hygiene","treatment_plan","treated_arch","bracket_system","slot","extraction_lower","anchorage_upper","created","updated","patient_id","habit","extraction_upper") VALUES (27,'class2','normal','deep','competent','dolichocephalic','class1','class2','deviated_to_left','coincidence','Overjet','Long','fair','No plan','mand','class3','Plot','class2','class1','2020-11-20 16:13:57.663460','2020-11-25 20:41:56.667709',48,'Naughty','class2');
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (56,'Lox CataloguePrint','upload_files/Positive_CoV_gR3R0D5.pdf','2020-11-03 11:48:46.508547','2020-11-06 12:34:20.015892',4,33,'pdf',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (57,'lox_logo','upload_files/Fig_72_-_MOIT_-_PROPOSAL_wF08UCi.pdf','2020-11-03 11:49:09.412326','2020-11-06 12:35:31.273184',4,33,'pdf',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (58,'Remdisivir','upload_files/Slemani_Govt_-_4374-20_-_20.07.27.pdf','2020-11-03 11:49:37.739824','2020-11-06 12:35:36.875538',4,33,'pdf',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (59,'lox_logo','upload_files/AXIS_-_Qirga_-_20-20.pdf','2020-11-03 12:09:33.840634','2020-11-06 12:35:42.123407',4,33,'pdf',3);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (60,'Nano Antibiotic','upload_files/LK.pdf','2020-11-03 12:14:56.272155','2020-11-06 12:35:47.008850',4,32,'pdf',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (61,'lox_logo','upload_files/Lox_Cover-02.jpg','2020-11-03 12:45:39.892453','2020-11-06 12:35:55.463161',4,33,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (62,'Fig Plus Logo V01-01','upload_files/Gabriel-Capture.JPG','2020-11-03 12:45:57.863442','2020-11-06 12:36:04.826410',4,33,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (63,'Fig Plus Logo V01-01.jpg','upload_files/Capture_zheer.JPG','2020-11-03 12:46:15.880461','2020-11-06 12:36:26.061984',4,33,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (64,'Capture BB.JPG','upload_files/Capture_BB.JPG','2020-11-04 10:56:31.174883','2020-11-06 12:36:21.052100',4,33,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (65,'Remdisivir','upload_files/Final_Banner_r8iRb4q.jpg','2020-11-04 17:05:13.362369','2020-11-06 12:36:17.548087',4,32,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (70,'lox_logo','upload_files/Downtown_Sarchinar_kRARu1L.pdf','2020-11-07 17:13:22.696695','2020-11-07 17:13:22.731453',4,34,'pdf',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (71,'lox_logo','upload_files/06-10-06smile_16O8DDW.jpg','2020-11-07 17:13:55.793022','2020-11-07 17:13:55.798638',4,34,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (72,'curation-probiotic-enumerationbyflowcytometry-poster.pdf','upload_files/curation-probiotic-enumerationbyflowcytometry-poster_jkw6GU7.pdf','2020-11-07 17:14:53.498150','2020-11-07 17:14:53.560426',4,34,'pdf',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (73,'IMG_20180910_081801.jpg','upload_files/IMG_20180910_081801_IBbukJm.jpg','2020-11-07 17:15:04.286306','2020-11-07 17:15:04.304913',4,34,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (82,'Positive CoV.pdf','upload_files/Positive_CoV_3jgNudk.pdf','2020-11-21 15:03:19.636898','2020-11-21 15:03:19.659908',4,48,'pdf',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (83,'48fbf55697cb61645ac5a24a7c673a5a.jpg','upload_files/48fbf55697cb61645ac5a24a7c673a5a.jpg','2020-11-21 15:03:27.129385','2020-11-21 15:03:27.135415',4,48,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (84,'AXIS - Qirga - 20-20.pdf','upload_files/AXIS_-_Qirga_-_20-20_LM2v3tm.pdf','2020-11-21 15:08:14.612395','2020-11-21 15:08:14.627396',4,48,'pdf',3);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (85,'0245380e1552c1b4f56f01345005f44a.jpg','upload_files/0245380e1552c1b4f56f01345005f44a.jpg','2020-11-21 15:08:20.944741','2020-11-21 15:08:20.950742',4,48,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (86,'Albuquerque+best+senior+photography-37.jpg','upload_files/Albuquerquebestseniorphotography-37.jpg','2020-11-21 15:08:26.902857','2020-11-21 15:08:26.907858',4,48,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (87,'DALYA - WAREHOUSE.pdf','upload_files/DALYA_-_WAREHOUSE.pdf','2020-11-22 10:17:11.771990','2020-11-22 10:17:11.799880',4,44,'pdf',2);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (88,'Follow-These-Steps-for-a-Flawless-Professional-Profile-Picture-Thumbnail.jpg','upload_files/Follow-These-Steps-for-a-Flawless-Professional-Profile-Picture-Thumbnail.jpg','2020-11-22 10:17:42.228233','2020-11-22 10:17:42.237188',4,44,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (89,'73a1998e3c7ac306225ccca406b5ffdf.jpg','upload_files/73a1998e3c7ac306225ccca406b5ffdf_zNF0fCS.jpg','2020-11-22 10:17:48.851980','2020-11-22 10:17:48.857004',4,44,'image',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (90,'Metrica - Responsive Bootstrap 4 Admin Dashboard.pdf','upload_files/Metrica_-_Responsive_Bootstrap_4_Admin_Dashboard.pdf','2020-11-22 10:18:13.984032','2020-11-22 10:18:13.995952',4,44,'pdf',2);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (91,'evaluation-of.pdf','upload_files/evaluation-of_cmYrTwR.pdf','2020-12-08 20:23:50.885799','2020-12-08 20:23:50.930679',4,47,'pdf',1);
INSERT INTO "core_attachment" ("id","filename","file","created","updated","user_id","patient_id","file_type","page_count") VALUES (92,'2016-11-06_0005.jpg','upload_files/2016-11-06_0005.jpg','2020-12-09 16:14:06.691727','2020-12-09 16:14:06.697773',4,38,'image',1);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (75,73,56);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (76,73,57);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (77,73,58);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (78,73,59);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (79,73,61);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (80,73,62);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (81,73,63);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (82,75,64);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (83,76,65);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (91,77,70);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (92,77,71);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (93,78,72);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (94,78,73);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (95,80,82);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (96,80,83);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (97,81,84);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (98,81,85);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (99,81,86);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (100,86,88);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (101,86,89);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (102,86,90);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (103,86,87);
INSERT INTO "core_treatment_files" ("id","treatment_id","attachment_id") VALUES (104,94,91);
INSERT INTO "authtoken_token" ("key","created","user_id") VALUES ('de921a8decc57d5c2bdddd59ece0ebbbb04abf66','2020-10-19 09:41:00.054701',1);
INSERT INTO "authtoken_token" ("key","created","user_id") VALUES ('105947a66ae3eb6c5147fc72903b7598d896b182','2020-10-26 17:45:49.827144',4);
INSERT INTO "authtoken_token" ("key","created","user_id") VALUES ('6c3090b75881a15c8d57d01118da7d8d9b7ad751','2020-10-27 09:41:39.281732',7);
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('cb0lnoumujwv95gmosuh69mnyhz6yul8','.eJxVjDsOwjAQBe_iGln2-oOXkj5nsNY_HEC2FCcV4u4QKQW0b2bei3na1uq3kRc_J3ZhwE6_W6D4yG0H6U7t1nnsbV3mwHeFH3Twqaf8vB7u30GlUb91gLNFp8BKY8Fh1OjIAJJOFKSWKEkJlM5qUSwIQwKxUEJdgg1FFcXeH6NrNr8:1kTgMd:iVH8Jh-gEOHedHYGyeSQOa1OMXSjGp46D-UolKsslKo','2020-10-31 07:10:51.591501');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('67b092sytlvxzgs1xhhl2bsnpq4p430w','.eJxVjTsOgzAQRO_iOrK8_mGnTM8ZrMXrDSQRljBUUe4ekCiSdt6bmbdIuK1j2lpZ0kTiKqy4_GYD5meZD0APnO9V5jqvyzTIQ5EnbbKvVF630_0bGLGNe9toxQgM0RryijK5CBmC80ExaHZAxurcQSkGY0avkLugmfcHzQai-HwB1w839A:1kXICI:CtPy2kBx-vONSuUYwUNDfSAh1Xj3XIGKg7lRrVm8Fbo','2020-11-10 06:11:06.060652');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('3idvyh2bwknf41yyvfrp9u5zbtzbrtjv','.eJxVjTsOgzAQRO_iOrK8_mGnTM8ZrMXrDSQRljBUUe4ekCiSdt6bmbdIuK1j2lpZ0kTiKqy4_GYD5meZD0APnO9V5jqvyzTIQ5EnbbKvVF630_0bGLGNe9toxQgM0RryijK5CBmC80ExaHZAxurcQSkGY0avkLugmfcHzQai-HwB1w839A:1kaEUG:2gaqGbgjLQlvluG24g3jhYiMw3H7NRffWS6r3ZmozAk','2020-11-18 08:49:48.876734');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('t6aaxa3f0ylzvhbamkbsio97ucdy42dv','.eJxVjTsOgzAQRO_iOrK8_mGnTM8ZrMXrDSQRljBUUe4ekCiSdt6bmbdIuK1j2lpZ0kTiKqy4_GYD5meZD0APnO9V5jqvyzTIQ5EnbbKvVF630_0bGLGNe9toxQgM0RryijK5CBmC80ExaHZAxurcQSkGY0avkLugmfcHzQai-HwB1w839A:1kbRf5:8hHvSsUcBHTkTj06taFv0xpGIlpAQWDSAoYmRduoy5Q','2020-11-21 17:05:59.135736');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('gpcp8pcc87031odyms7wuv35vobkwbzn','.eJxVjTsOgzAQRO_iOrK8_mGnTM8ZrMXrDSQRljBUUe4ekCiSdt6bmbdIuK1j2lpZ0kTiKqy4_GYD5meZD0APnO9V5jqvyzTIQ5EnbbKvVF630_0bGLGNe9toxQgM0RryijK5CBmC80ExaHZAxurcQSkGY0avkLugmfcHzQai-HwB1w839A:1kfMPn:rqW_snPEHAX8iBPcTwi1NE5yn7SMsyiBjH61DstgYkQ','2020-12-02 15:18:23.877910');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('d5ddabduo1pecyiwnaz7rg0l77wrcpby','.eJxVjTsOgzAQRO_iOrK8_mGnTM8ZrMXrDSQRljBUUe4ekCiSdt6bmbdIuK1j2lpZ0kTiKqy4_GYD5meZD0APnO9V5jqvyzTIQ5EnbbKvVF630_0bGLGNe9toxQgM0RryijK5CBmC80ExaHZAxurcQSkGY0avkLugmfcHzQai-HwB1w839A:1kgY53:EZ6DPA-CZBwTUYqn63kHQ8zZKfqeoCAENh52LvWNv-U','2020-12-05 21:57:53.549294');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('xvg25iwf8xbuseb4e0648m5hcafmpsdb','.eJxVjTsOgzAQRO_iOrK8_mGnTM8ZrMXrDSQRljBUUe4ekCiSdt6bmbdIuK1j2lpZ0kTiKqy4_GYD5meZD0APnO9V5jqvyzTIQ5EnbbKvVF630_0bGLGNe9toxQgM0RryijK5CBmC80ExaHZAxurcQSkGY0avkLugmfcHzQai-HwB1w839A:1klclf:EDDJ7Bse-2u7VBFJ-VVKXQnX2wrIgccEgjxeoFRgyPE','2020-12-19 21:58:51.814807');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('2445f6ienhri9tj1lmqx1qzfetpriwot','.eJxVjTsOgzAQRO_iOrK8_mGnTM8ZrMXrDSQRljBUUe4ekCiSdt6bmbdIuK1j2lpZ0kTiKqy4_GYD5meZD0APnO9V5jqvyzTIQ5EnbbKvVF630_0bGLGNe9toxQgM0RryijK5CBmC80ExaHZAxurcQSkGY0avkLugmfcHzQai-HwB1w839A:1klp2Q:N7M0EX_aS9QKkkxLgUsxeHMbKnXeftwLF9-Fc_WEk0w','2020-12-20 11:04:58.808718');
INSERT INTO "core_doctor" ("id","name","degree","dob","age","gender","phone","email","description","status","address_id","user_id") VALUES (1,'Handren Ameer Kurda','PhD','1985-08-03',NULL,'male','07701570615','darya.ibrahim@imperialknight.com','',1,NULL,1);
INSERT INTO "core_appointment" ("id","patient_id","date","time","note","user_id") VALUES (3,5,'2020-10-15','12:35:00','',1);
INSERT INTO "core_appointment" ("id","patient_id","date","time","note","user_id") VALUES (5,NULL,'2020-10-19','16:30:00','',1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (1,'2020-10-11 16:51:58.830998','1','Handren Othman','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (2,'2020-10-13 08:11:27.855703','1','Zhilwan Jaza - 2020-10-13 08:11:27.852668+00:00','[{"added": {}}]',15,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (3,'2020-10-13 11:46:49.054124','1','Handren Ameer Kurda','[{"changed": {"fields": ["Name"]}}]',8,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (4,'2020-10-13 11:55:44.688265','2','handren.kurda@gmail.com','[{"added": {}}]',6,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (5,'2020-10-13 11:57:31.410624','2','handren.kurda@gmail.com','[{"changed": {"fields": ["Name", "Is staff"]}}]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (6,'2020-10-13 11:58:16.933742','2','handren.kurda@gmail.com','[{"changed": {"fields": ["Superuser status"]}}]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (7,'2020-10-16 04:12:12.052427','100','Attachment object (100)','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (8,'2020-10-16 04:12:18.752508','4','Shakar Abdulqadir - 2020-10-16 04:12:18.746590+00:00','[{"added": {}}]',15,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (9,'2020-10-16 06:15:45.989205','9','Shakar Abdulqadir - 2020-10-16 06:15:45.986137+00:00','[{"added": {}}]',15,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (10,'2020-10-16 10:46:55.827931','14','Nsar Khalifa - 2020-10-16 10:45:45.980087+00:00','[{"changed": {"fields": ["Files"]}}]',15,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (11,'2020-10-16 11:14:21.370853','180','/media/upload_files/Downtown_Sarchinar_DQVBN3y.pdf','[{"changed": {"fields": ["Filename"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (12,'2020-10-16 11:14:35.892929','179','/media/upload_files/Downtown_Sarchinar_jUsgVrs.docx','[{"changed": {"fields": ["Filename"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (13,'2020-10-16 11:17:45.588224','181','/media/upload_files/Downtown_Sarchinar_hit9uDs.docx','[{"changed": {"fields": ["Filename"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (14,'2020-10-16 16:57:16.677683','14','Rabar Karim','[{"changed": {"fields": ["Dob"]}}]',11,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (15,'2020-10-16 16:57:31.475046','14','Rabar Karim','[{"changed": {"fields": ["Age"]}}]',11,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (16,'2020-10-19 12:33:32.475053','1','darya.ibrahim@imperialknight.com','[{"changed": {"fields": ["Email", "Name", "Last login"]}}]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (17,'2020-10-19 12:33:44.985971','1','root@root.com','[{"changed": {"fields": ["Email"]}}]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (18,'2020-10-22 20:22:57.070328','21','Sakar Abdulla - 2020-10-22 20:22:57.063590+00:00','[{"added": {}}]',15,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (19,'2020-10-23 18:49:39.433125','21','Sakar Abdulla - 2020-10-22 20:22:57.063590+00:00','[{"changed": {"fields": ["User"]}}]',15,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (20,'2020-10-23 18:57:58.893947','20','Rozhgar Anwar - 2020-10-17 06:12:57.204200+00:00','[]',15,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (21,'2020-10-26 17:38:51.590795','1','root@root.com','[{"changed": {"fields": ["password"]}}]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (22,'2020-10-26 17:39:14.272459','1','darya.ibrahim@imperialknight.com','[{"changed": {"fields": ["Email", "Name", "Last login"]}}]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (23,'2020-10-26 18:37:20.686921','4','root@root.com','[{"changed": {"fields": ["Name", "Last login"]}}]',6,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (24,'2020-10-27 11:37:28.976842','36','Diar Salim - 2020-10-27 11:37:28.973843+00:00','[{"added": {}}]',15,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (25,'2020-10-29 19:32:10.930546','284','/media/upload_files/085_Change_quantity_mutation.en_74RTIwH.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (26,'2020-10-29 19:32:10.953082','283','/media/upload_files/082_Getters_and_computed.en_VCSrkak.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (27,'2020-10-29 19:32:10.974586','282','/media/upload_files/082_Getters_and_computed.en_n3UopBh.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (28,'2020-10-29 19:32:10.993410','281','/media/upload_files/079_State_and_action.en_enKq8hf.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (29,'2020-10-29 19:32:11.013957','280','/media/upload_files/080_Mutations.en_XPSOi1w.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (30,'2020-10-29 19:32:11.032773','279','/media/upload_files/Lox_Parwezkhan_Letterhead_-_PRINT_-_20.07.28-04_qkgc1uU.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (31,'2020-10-29 19:32:11.053870','278','/media/upload_files/kele-letterhead_iEJkDYv.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (32,'2020-10-29 19:32:11.079098','277','/media/upload_files/pishta-letterhead.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (33,'2020-10-29 19:32:11.096523','276','/media/upload_files/Lox_Parwezkhan_Letterhead_-_PRINT_-_20.07.28-04_2PMcI5K.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (34,'2020-10-29 19:32:11.114713','275','/media/upload_files/Lox_Parwezkhan_Letterhead_-_PRINT_-_20.07.28-04_iaihJCt.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (35,'2020-10-29 19:32:11.133996','274','/media/upload_files/kele-letterhead_uGcYvbF.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (36,'2020-10-29 19:32:11.154753','273','/media/upload_files/Lox_Parwezkhan_Letterhead_-_PRINT_-_20.07.28-04.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (37,'2020-10-29 19:32:11.173175','272','/media/upload_files/kele-letterhead_odoNXdU.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (38,'2020-10-29 19:32:11.199494','271','/media/upload_files/Lox_Parwezkhan_Letterhead_-_PRINT_-_20.07.28-05.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (39,'2020-10-29 19:32:11.223304','270','/media/upload_files/kele-letterhead.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (40,'2020-10-29 19:32:11.243012','269','/media/upload_files/dastan-3.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (41,'2020-10-29 19:32:11.263676','267','/media/upload_files/Capturealpha_xbKYebD.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (42,'2020-10-29 19:32:11.281489','266','/media/upload_files/AXIS_-_Qirga_-_20-20_wYn7TbH.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (43,'2020-10-29 19:32:11.301703','265','/media/upload_files/DALYA_-_Fridge_-Proposal_-_V02_8Sol3i4.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (44,'2020-10-29 19:32:11.323452','264','/media/upload_files/Capture_BB_JkSrX8u.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (45,'2020-10-29 19:32:11.344823','263','/media/upload_files/AXIS_-_Qirga_-_20-20_pzbG9eX.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (46,'2020-10-29 19:32:11.363227','262','/media/upload_files/Capture_-_Domain_Expired_I1BRUTJ.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (47,'2020-10-29 19:32:11.381450','261','/media/upload_files/codepen_ZAUHLGu.txt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (48,'2020-10-29 19:32:11.395972','260','/media/upload_files/Capture_Omar_kUmkWBP.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (49,'2020-10-29 19:32:11.412324','259','/media/upload_files/Capture_BB_VVrE2fN.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (50,'2020-10-29 19:32:11.430314','258','/media/upload_files/AXIS_-_Qirga_-_20-20_d5yX9cX.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (51,'2020-10-29 19:32:11.446115','257','/media/upload_files/AXIS_-_Qirga_-_20-20_GmTY9pI.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (52,'2020-10-29 19:32:11.463016','256','/media/upload_files/AXIS_-_Qirga_-_20-20_SBin9QL.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (53,'2020-10-29 19:32:11.479157','255','/media/upload_files/Capture_BB_716ggsO.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (54,'2020-10-29 19:32:11.495736','254','/media/upload_files/AXIS_-_Qirga_-_20-20_wxhOnGR.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (55,'2020-10-29 19:32:11.516760','253','/media/upload_files/AXIS_-_Qirga_-_20-20_wtlfiSt.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (56,'2020-10-29 19:32:11.540317','252','/media/upload_files/Capture_zheer_Q1iOnOo.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (57,'2020-10-29 19:32:11.566237','251','/media/upload_files/AXIS_-_20-38_-_letter_ykoXCj9.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (58,'2020-10-29 19:32:11.586614','250','/media/upload_files/Capture_BB_9vkwQzK.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (59,'2020-10-29 19:32:11.604714','249','/media/upload_files/Capture_BB_44L44ro.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (60,'2020-10-29 19:32:11.627528','248','/media/upload_files/Capture_Omar_g0n8RYp.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (61,'2020-10-29 19:32:11.643806','247','/media/upload_files/AXIS_-_20-38_-_letter_igYXtPr.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (62,'2020-10-29 19:32:11.671398','246','/media/upload_files/Capture_Omar_JbuUSEB.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (63,'2020-10-29 19:32:11.688369','245','/media/upload_files/AXIS_-_Qirga_-_20-20_hWM8tls.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (64,'2020-10-29 19:32:11.712808','244','/media/upload_files/Fig_71_-_Majidi_Mall_-Rezan_Permistion_hA3mIK1.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (65,'2020-10-29 19:32:11.739010','243','/media/upload_files/Capture_BB_lOk8Lpg.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (66,'2020-10-29 19:32:11.761917','242','/media/upload_files/Capture_Omar_jMwSYHV.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (67,'2020-10-29 19:32:11.784324','241','/media/upload_files/AXIS_-_Qirga_-_20-20_3FtOi6a.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (68,'2020-10-29 19:32:11.809861','240','/media/upload_files/AXIS_-_Qirga_-_20-20_bI1zwkA.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (69,'2020-10-29 19:32:11.838587','239','/media/upload_files/Capturealpha_PMtWzJr.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (70,'2020-10-29 19:32:11.863054','238','/media/upload_files/AXIS_-_Qirga_-_20-20_iPEy3Pf.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (71,'2020-10-29 19:32:11.893066','237','/media/upload_files/Capture_Omar_vUuC2NO.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (72,'2020-10-29 19:32:11.926321','236','/media/upload_files/AXIS_-_Qirga_-_20-20_jt78xtm.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (73,'2020-10-29 19:32:11.949899','235','/media/upload_files/Capture_zheer_c5ZOgyF.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (74,'2020-10-29 19:32:11.991827','234','/media/upload_files/Fig_Plus-082520.ptb','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (75,'2020-10-29 19:32:12.025441','233','/media/upload_files/Fig_71_-_Majidi_Mall_-Rezan_Permistion_RuwkHgR.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (76,'2020-10-29 19:32:12.050570','232','/media/upload_files/DALYA_-_Fridge_-Proposal_-_V02_hIJvlUS.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (77,'2020-10-29 19:32:12.078480','231','/media/upload_files/Capture_-_Domain_Expired.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (78,'2020-10-29 19:32:12.104658','230','/media/upload_files/AXIS_-_20-38_-_letter_tzbBu8o.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (79,'2020-10-29 19:32:12.130516','229','/media/upload_files/Capture_Omar_WCcFdFL.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (80,'2020-10-29 19:32:12.159670','228','/media/upload_files/Capture_BB_o74gviu.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (81,'2020-10-29 19:32:12.188405','227','/media/upload_files/Fig_71_-_Majidi_Mall_-Rezan_Permistion_ygwaTzl.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (82,'2020-10-29 19:32:12.219790','226','/media/upload_files/AXIS_-_Qirga_-_20-20_e76gPZH.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (83,'2020-10-29 19:32:12.256663','225','/media/upload_files/Gabriel-Capture_zFdnA88.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (84,'2020-10-29 19:32:12.278423','224','/media/upload_files/Fig_71_-_Majidi_Mall_-Rezan_Permistion_DxH4T0e.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (85,'2020-10-29 19:32:12.304663','223','/media/upload_files/GoIP_Network.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (86,'2020-10-29 19:32:12.330928','222','/media/upload_files/Capture_BB_2iKioEX.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (87,'2020-10-29 19:32:12.356145','221','/media/upload_files/DALYA_-_Fridge_-Proposal_-_V02.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (88,'2020-10-29 19:32:12.391022','220','/media/upload_files/Capture_BB_vlk1xMP.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (89,'2020-10-29 19:32:12.420979','219','/media/upload_files/Capture_zheer.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (90,'2020-10-29 19:32:12.448481','218','/media/upload_files/Fig_71_-_Majidi_Mall_-Rezan_Permistion_1y1R3v8.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (91,'2020-10-29 19:32:12.484605','217','/media/upload_files/codepen.txt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (92,'2020-10-29 19:32:12.511994','216','/media/upload_files/Gabriel-Capture.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (93,'2020-10-29 19:32:12.537881','215','/media/upload_files/Fig_71_-_Majidi_Mall_-Rezan_Permistion.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (94,'2020-10-29 19:32:12.563494','214','/media/upload_files/Capture_Omar_Xa00tI6.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (95,'2020-10-29 19:32:12.589357','213','/media/upload_files/Capturealpha.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (96,'2020-10-29 19:32:12.609508','212','/media/upload_files/Capture_Omar.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (97,'2020-10-29 19:32:12.628945','211','/media/upload_files/AXIS_-_Qirga_-_20-20_LevTiYD.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (98,'2020-10-29 19:32:12.650386','210','/media/upload_files/AXIS_-_Qirga_-_20-20.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (99,'2020-10-29 19:32:12.677447','209','/media/upload_files/Capture_BB_pQ5hvD9.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (100,'2020-10-29 19:32:12.698829','208','/media/upload_files/AXIS_-_Qirga_-_20-20.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (101,'2020-10-29 19:32:12.723401','207','/media/upload_files/Capture_BB.JPG','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (102,'2020-10-29 19:32:12.754803','206','/media/upload_files/AXIS_-_20-38_-_letter.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (103,'2020-10-29 19:32:12.779966','205','/media/upload_files/085_Change_quantity_mutation.en_tFRwyi0.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (104,'2020-10-29 19:32:12.809187','204','/media/upload_files/080_Mutations.en_9Io2GL6.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (105,'2020-10-29 19:32:12.837336','203','/media/upload_files/085_Change_quantity_mutation.en_fVzCQgS.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (106,'2020-10-29 19:32:12.860957','202','/media/upload_files/082_Getters_and_computed.en_ka0HMNF.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (107,'2020-10-29 19:32:12.889407','201','/media/upload_files/080_Mutations.en_nCtExMx.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (108,'2020-10-29 19:32:12.913163','200','/media/upload_files/079_State_and_action.en_jQIDc3q.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (109,'2020-10-29 19:32:12.938424','199','/media/upload_files/082_Getters_and_computed.en.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (110,'2020-10-29 19:32:12.972259','198','/media/upload_files/085_Change_quantity_mutation.en_iyGAfPu.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (111,'2020-10-29 19:32:12.995948','197','/media/upload_files/086_Delete_product_mutation.en.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (112,'2020-10-29 19:32:13.029336','194','/media/upload_files/080_Mutations.en_zAUDQ5C.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (113,'2020-10-29 19:32:13.056131','193','/media/upload_files/084_Persist_Vuex_in_localStorage.en.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (114,'2020-10-29 19:32:13.077032','192','/media/upload_files/079_State_and_action.en_FPjBewQ.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (115,'2020-10-29 19:32:13.100730','191','/media/upload_files/081_Import_Action_in_Product_Page.en_q1tgpzT.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (116,'2020-10-29 19:32:13.127102','190','/media/upload_files/080_Mutations.en.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (117,'2020-10-29 19:32:13.147933','189','/media/upload_files/079_State_and_action.en.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (118,'2020-10-29 19:32:13.173861','188','/media/upload_files/081_Import_Action_in_Product_Page.en.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (119,'2020-10-29 19:32:13.199594','187','/media/upload_files/085_Change_quantity_mutation.en.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (120,'2020-10-29 19:32:13.230928','186','/media/upload_files/background_ETqZzOX.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (121,'2020-10-29 19:32:13.256938','185','/media/upload_files/medical_supply_us_catalogue_9LcxHoo.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (122,'2020-10-29 19:32:13.278149','184','/media/upload_files/IMG_20180910_081801_OwtrYAU.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (123,'2020-10-29 19:32:13.300232','183','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_VXigk1Q.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (124,'2020-10-29 19:32:13.327360','182','/media/upload_files/figs_mask-04-02_oBSwEBE.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (125,'2020-10-29 19:32:48.510143','181','/media/upload_files/Downtown_Sarchinar_hit9uDs.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (126,'2020-10-29 19:32:48.532999','180','/media/upload_files/Downtown_Sarchinar_DQVBN3y.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (127,'2020-10-29 19:32:48.560965','179','/media/upload_files/Downtown_Sarchinar_jUsgVrs.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (128,'2020-10-29 19:32:48.580507','178','/media/upload_files/IMG_20180910_081801_CNQIuVm.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (129,'2020-10-29 19:32:48.603592','177','/media/upload_files/Downtown_Sarchinar_KqC8MJ3.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (130,'2020-10-29 19:32:48.631037','176','/media/upload_files/Single_wLrMkLI.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (131,'2020-10-29 19:32:48.652667','175','/media/upload_files/curation-probiotic-enumerationbyflowcytometry-poster_vukXpYH.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (132,'2020-10-29 19:32:48.672211','174','/media/upload_files/figs_mask-04-02_xz9xnbw.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (133,'2020-10-29 19:32:48.692851','173','/media/upload_files/Mohammed_Ibrahim_Accounting_Report_-_20.08.17_JWRX3tl.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (134,'2020-10-29 19:32:48.713531','172','/media/upload_files/Mohammed_Ibrahim_Accounting_Report_-_20.08.17.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (135,'2020-10-29 19:32:48.734330','171','/media/upload_files/Downtown_Sarchinar_01A9D6r.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (136,'2020-10-29 19:32:48.757611','170','/media/upload_files/Single_JgrYsjj.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (137,'2020-10-29 19:32:48.777444','168','/media/upload_files/Downtown_Sarchinar_Gsb3lBZ.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (138,'2020-10-29 19:32:48.805568','167','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_E78Ub6h.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (139,'2020-10-29 19:32:48.833237','166','/media/upload_files/Downtown_Sarchinar_zQQMYzL.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (140,'2020-10-29 19:32:48.861343','165','/media/upload_files/figs_mask-01_6GTxS1g.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (141,'2020-10-29 19:32:48.891013','163','/media/upload_files/figs_mask-04-02.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (142,'2020-10-29 19:32:48.916430','162','/media/upload_files/IMG_20180910_081801_asPlbJv.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (143,'2020-10-29 19:32:48.947925','161','/media/upload_files/background_F5KTrYb.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (144,'2020-10-29 19:32:48.970059','160','/media/upload_files/Fig_Plus_Logo_V01_y2wuXk4.ai','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (145,'2020-10-29 19:32:49.011569','159','/media/upload_files/Downtown_Sarchinar_4TPBal9.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (146,'2020-10-29 19:32:49.045129','158','/media/upload_files/curation-probiotic-enumerationbyflowcytometry-poster_grs3KKl.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (147,'2020-10-29 19:32:49.082364','157','/media/upload_files/Downtown_Sarchinar_XbrGSKy.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (148,'2020-10-29 19:32:49.107807','156','/media/upload_files/Downtown_Sarchinar_OHwcbR1.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (149,'2020-10-29 19:32:49.135505','155','/media/upload_files/curation-probiotic-enumerationbyflowcytometry-poster_2BSJtri.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (150,'2020-10-29 19:32:49.160661','154','/media/upload_files/Downtown_Sarchinar_2zl9nhX.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (151,'2020-10-29 19:32:49.182878','153','/media/upload_files/Fig_Plus_Logo_V01_uEHBpC5.ai','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (152,'2020-10-29 19:32:49.210865','152','/media/upload_files/Downtown_Sarchinar_drUatO8.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (153,'2020-10-29 19:32:49.235205','151','/media/upload_files/background_zRs9pgl.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (154,'2020-10-29 19:32:49.258137','150','/media/upload_files/Downtown_Sarchinar_4BgVUmL.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (155,'2020-10-29 19:32:49.285032','149','/media/upload_files/Downtown_Sarchinar_UGnMqxR.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (156,'2020-10-29 19:32:49.307779','148','/media/upload_files/Downtown_Sarchinar_rhgP3KO.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (157,'2020-10-29 19:32:49.333352','147','/media/upload_files/curation-probiotic-enumerationbyflowcytometry-poster_Jy5GZHk.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (158,'2020-10-29 19:32:49.356737','146','/media/upload_files/Downtown_Sarchinar_qRnc2DK.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (159,'2020-10-29 19:32:49.378891','145','/media/upload_files/Downtown_Sarchinar_w7yovXd.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (160,'2020-10-29 19:32:49.408930','144','/media/upload_files/Downtown_Sarchinar_MqOqNMI.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (161,'2020-10-29 19:32:49.431024','143','/media/upload_files/Downtown_Sarchinar_5Np0c5J.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (162,'2020-10-29 19:32:49.457694','142','/media/upload_files/curation-probiotic-enumerationbyflowcytometry-poster_AKTyHwH.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (163,'2020-10-29 19:32:49.481016','141','/media/upload_files/Downtown_Sarchinar_Ww02qRL.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (164,'2020-10-29 19:32:49.505833','140','/media/upload_files/curation-probiotic-enumerationbyflowcytometry-poster_wJjRd4U.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (165,'2020-10-29 19:32:49.528339','139','/media/upload_files/Downtown_Sarchinar_kvwHfS9.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (166,'2020-10-29 19:32:49.553186','138','/media/upload_files/Downtown_Sarchinar_JYtSm1G.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (167,'2020-10-29 19:32:49.572565','137','/media/upload_files/evaluation-of_dupB8OO.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (168,'2020-10-29 19:32:49.591965','136','/media/upload_files/Downtown_Sarchinar_mRKVOVO.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (169,'2020-10-29 19:32:49.610092','135','/media/upload_files/IMG_20180910_081801_MVV6rV6.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (170,'2020-10-29 19:32:49.625110','134','/media/upload_files/acount-page_dWAcn9m.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (171,'2020-10-29 19:32:49.647407','133','/media/upload_files/logo-sm-3_YZpCz8F.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (172,'2020-10-29 19:32:49.665064','132','/media/upload_files/logo-sm_tUFRK6a.ai','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (173,'2020-10-29 19:32:49.680740','131','/media/upload_files/logo-sm-2_pmzusFY.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (174,'2020-10-29 19:32:49.699008','130','/media/upload_files/acount-page.psd','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (175,'2020-10-29 19:32:49.717019','129','/media/upload_files/logo-sm_gyDTKli.ai','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (176,'2020-10-29 19:32:49.737666','128','/media/upload_files/500_g14kG7o.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (177,'2020-10-29 19:32:49.759245','127','/media/upload_files/acount-page_xx2LDFp.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (178,'2020-10-29 19:32:49.779065','126','/media/upload_files/logo-sm-2_zmp8dRq.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (179,'2020-10-29 19:32:49.798496','125','/media/upload_files/logo-sm-2.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (180,'2020-10-29 19:32:49.818432','124','/media/upload_files/logo-sm-3_omZXdYA.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (181,'2020-10-29 19:32:49.844616','123','/media/upload_files/logo-sm-3.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (182,'2020-10-29 19:32:49.863531','122','/media/upload_files/logo-sm.ai','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (183,'2020-10-29 19:32:49.884312','121','/media/upload_files/404_U4Jchpv.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (184,'2020-10-29 19:32:49.905168','120','/media/upload_files/acount-page.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (185,'2020-10-29 19:32:49.927896','119','/media/upload_files/404.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (186,'2020-10-29 19:32:49.948099','118','/media/upload_files/bell.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (187,'2020-10-29 19:32:49.968416','117','/media/upload_files/500_yAmCnJE.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (188,'2020-10-29 19:32:49.988324','116','/media/upload_files/acount-page-h1.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (189,'2020-10-29 19:32:50.008860','115','/media/upload_files/500.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (190,'2020-10-29 19:32:50.028910','114','/media/upload_files/vue_3S7T37t.js','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (191,'2020-10-29 19:32:50.051836','113','/media/upload_files/axios.min_2mvQayY.js','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (192,'2020-10-29 19:32:50.070193','112','/media/upload_files/axios.min_IC2R5HS.js','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (193,'2020-10-29 19:32:50.091903','111','/media/upload_files/vue.js','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (194,'2020-10-29 19:32:50.118205','110','/media/upload_files/axios.min.js','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (195,'2020-10-29 19:32:50.142783','109','/media/upload_files/UniQAIDAR_Blawkrawe001.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (196,'2020-10-29 19:32:50.162389','108','/media/upload_files/UniQAIDAR_DARA.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (197,'2020-10-29 19:32:50.181735','107','/media/upload_files/UniQAIDAR_Hewal000.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (198,'2020-10-29 19:32:50.202697','106','/media/upload_files/UniQAIDAR_Blawkrawe009.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (199,'2020-10-29 19:32:50.224050','105','/media/upload_files/UniQAIDAR_Blawkrawe013.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (200,'2020-10-29 19:32:50.246596','104','/media/upload_files/UniQAIDAR_Blawkrawe015.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (201,'2020-10-29 19:32:50.266702','103','/media/upload_files/UniQAIDAR_ASKANDAR.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (202,'2020-10-29 19:32:50.285262','102','/media/upload_files/UniQAIDAR_Blawkrawe006.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (203,'2020-10-29 19:32:50.306600','101','/media/upload_files/background_GQ9qUdu.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (204,'2020-10-29 19:32:50.328671','100','/media/upload_files/curation-probiotic-enumerationbyflowcytometry-poster_Z4ZniYW.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (205,'2020-10-29 19:32:50.347768','99','/media/upload_files/Downtown_Sarchinar_sNS053e.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (206,'2020-10-29 19:32:50.368156','98','/media/upload_files/Fig_Plus_Logo_V01-02_46uJber.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (207,'2020-10-29 19:32:50.391058','97','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_ZrEkXFA.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (208,'2020-10-29 19:32:50.411534','96','/media/upload_files/IMG_20180910_081801_sA4M0AO.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (209,'2020-10-29 19:32:50.432467','95','/media/upload_files/Face_Mask_v0sara-02_rbpukjY.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (210,'2020-10-29 19:32:50.451785','94','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_dbrYAYv.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (211,'2020-10-29 19:32:50.470720','93','/media/upload_files/Downtown_Sarchinar_mkKQqhu.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (212,'2020-10-29 19:32:50.499042','92','/media/upload_files/Downtown_Sarchinar_tXXQ0BF.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (213,'2020-10-29 19:32:50.528441','91','/media/upload_files/Fig_Plus_Logo_V01_WqpvH2g.ai','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (214,'2020-10-29 19:32:50.548841','90','/media/upload_files/curation-probiotic-enumerationbyflowcytometry-poster.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (215,'2020-10-29 19:32:50.567410','89','/media/upload_files/Face_Mask_v0sara-02_YUpnnF6.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (216,'2020-10-29 19:32:50.596758','88','/media/upload_files/Downtown_Sarchinar_5HDSM85.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (217,'2020-10-29 19:32:50.616929','86','/media/upload_files/Face_Mask_v0sara-02_VtWJaQE.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (218,'2020-10-29 19:32:50.640891','85','/media/upload_files/IMG_20180910_081801_QgOvqfY.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (219,'2020-10-29 19:32:50.660491','83','/media/upload_files/Face_Mask_v0sara-02_D5fiv0l.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (220,'2020-10-29 19:32:50.680413','81','/media/upload_files/Fig_Plus_Logo_V01_QWT9tEG.ai','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (221,'2020-10-29 19:32:50.700460','80','/media/upload_files/Face_Mask_v0sara-02_OM6v3vJ.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (222,'2020-10-29 19:32:50.736775','79','/media/upload_files/Untitled-2_CFlUT52.ai','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (223,'2020-10-29 19:32:50.760042','75','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_ZyJ4eNH.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (224,'2020-10-29 19:32:50.781199','74','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_3EqY35X.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (225,'2020-10-29 19:32:50.801668','73','/media/upload_files/Warning_-_figs_Vk9DPw5.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (226,'2020-10-29 19:32:50.822146','72','/media/upload_files/Untitled-2_nK4iS4f.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (227,'2020-10-29 19:32:50.844830','71','/media/upload_files/Untitled-2.ai','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (228,'2020-10-29 19:32:50.866743','69','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_98qv0dn.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (229,'2020-10-29 19:32:50.886472','68','/media/upload_files/Single_JGqjdBp.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (230,'2020-10-29 19:32:50.908872','67','/media/upload_files/evaluation-of_nXaKADv.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (231,'2020-10-29 19:32:50.934782','66','/media/upload_files/figs_mask-01.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (232,'2020-10-29 19:32:50.960672','65','/media/upload_files/Kanit-Light_QKyaWgl.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (233,'2020-10-29 19:32:50.988449','64','/media/upload_files/Kanit-SemiBold.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (234,'2020-10-29 19:32:51.014250','62','/media/upload_files/Kanit-ExtraBoldItalic_LVOA1i1.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (235,'2020-10-29 19:32:51.037051','61','/media/upload_files/Kanit-Light_ObYLON9.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (236,'2020-10-29 19:32:51.060279','60','/media/upload_files/Kanit-ExtraLightItalic.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (237,'2020-10-29 19:32:51.083383','59','/media/upload_files/Kanit-Light.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (238,'2020-10-29 19:32:51.109879','58','/media/upload_files/Kanit-Thin.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (239,'2020-10-29 19:32:51.132328','57','/media/upload_files/Kanit-SemiBoldItalic.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (240,'2020-10-29 19:32:51.154310','56','/media/upload_files/Kanit-ExtraBoldItalic.ttf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (241,'2020-10-29 19:32:51.178221','55','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (242,'2020-10-29 19:32:51.202097','54','/media/upload_files/evaluation-of_pqQnf7m.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (243,'2020-10-29 19:32:51.231034','53','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (244,'2020-10-29 19:32:51.252722','52','/media/upload_files/figs_mask-02-02.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (245,'2020-10-29 19:32:51.279008','51','/media/upload_files/Warning_-_figs.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (246,'2020-10-29 19:32:51.300338','50','/media/upload_files/Single_tYqdxXE.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (247,'2020-10-29 19:32:51.326650','49','/media/upload_files/zane_nlR61yI.html','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (248,'2020-10-29 19:32:51.347989','48','/media/upload_files/Untitled-2.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (249,'2020-10-29 19:32:51.370100','47','/media/upload_files/Single.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (250,'2020-10-29 19:32:51.396443','46','/media/upload_files/Downtown_Sarchinar_1VPMyW8.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (251,'2020-10-29 19:32:51.420971','45','/media/upload_files/zane.html','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (252,'2020-10-29 19:32:51.448682','44','/media/upload_files/package_PQb07ud.json','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (253,'2020-10-29 19:32:51.470414','43','/media/upload_files/package-lock_WHgjBDK.json','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (254,'2020-10-29 19:32:51.496466','42','/media/upload_files/package-lock_ovzf5pv.json','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (255,'2020-10-29 19:32:51.521304','41','/media/upload_files/package-lock.json','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (256,'2020-10-29 19:32:51.547801','40','/media/upload_files/package.json','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (257,'2020-10-29 19:32:51.575609','39','/media/upload_files/Darya_Nationality_ID_0oWgMfR.psd','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (258,'2020-10-29 19:32:51.598865','38','/media/upload_files/medical_supply_us_catalogue_wWf9w5a.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (259,'2020-10-29 19:32:51.617439','37','/media/upload_files/medical_supply_us_catalogue_rGzjGFe.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (260,'2020-10-29 19:32:51.642667','36','/media/upload_files/error.html','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (261,'2020-10-29 19:32:51.663409','35','/media/upload_files/surgMask_vbkIFTz.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (262,'2020-10-29 19:32:51.691610','34','/media/upload_files/surgMask_9yOTVtH.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (263,'2020-10-29 19:32:51.714522','33','/media/upload_files/Darya_Nationality_ID_iZ6iBJF.psd','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (264,'2020-10-29 19:32:51.737204','32','/media/upload_files/medical_supply_us_catalogue_rGw9zQ7.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (265,'2020-10-29 19:32:51.759230','31','/media/upload_files/medical_supply_us_catalogue_fgp4be4.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (266,'2020-10-29 19:32:51.782500','30','/media/upload_files/Darya_Nationality_ID.psd','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (267,'2020-10-29 19:32:51.804131','29','/media/upload_files/surgMask_O5JSh0e.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (268,'2020-10-29 19:32:51.826991','28','/media/upload_files/background_UuqTugF.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (269,'2020-10-29 19:32:51.849041','27','/media/upload_files/figs_mask-03-02.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (270,'2020-10-29 19:32:51.876293','26','/media/upload_files/IMG_20180910_081801.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (271,'2020-10-29 19:32:51.898722','25','/media/upload_files/Downtown_Sarchinar_djB3vSj.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (272,'2020-10-29 19:32:51.918793','24','/media/upload_files/Fig_Plus_Logo_V01_3HfB1Nw.ai','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (273,'2020-10-29 19:32:51.943208','23','/media/upload_files/background_QSkFYJQ.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (274,'2020-10-29 19:32:51.963992','22','/media/upload_files/Face_Mask_v0sara-02_C6HiOmG.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (275,'2020-10-29 19:32:51.984711','21','/media/upload_files/Downtown_Sarchinar.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (276,'2020-10-29 19:32:52.008815','20','/media/upload_files/evaluation-of.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (277,'2020-10-29 19:32:52.032177','19','/media/upload_files/Downtown_Sarchinar.docx','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (278,'2020-10-29 19:32:52.053631','18','/media/upload_files/background_Z64KXzN.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (279,'2020-10-29 19:32:52.079544','17','/media/upload_files/background_vtDZAIo.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (280,'2020-10-29 19:32:52.100667','16','/media/upload_files/background_A706QCW.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (281,'2020-10-29 19:32:52.130140','15','/media/upload_files/background_MVtnEnt.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (282,'2020-10-29 19:32:52.149652','14','/media/upload_files/Face_Mask_v0sara-02_HbtuS5k.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (283,'2020-10-29 19:32:52.167888','13','/media/upload_files/Face_Mask_v0sara-02_2GLenvv.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (284,'2020-10-29 19:32:52.188358','12','/media/upload_files/Fig_Plus_Logo_V01.ai','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (285,'2020-10-29 19:32:52.210488','11','/media/upload_files/surgMask_qIVn08L.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (286,'2020-10-29 19:32:52.235550','10','/media/upload_files/surgMask_8O7vbiN.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (287,'2020-10-29 19:32:52.261849','9','/media/upload_files/surgMask.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (288,'2020-10-29 19:32:52.283697','8','/media/upload_files/Screen_Shot_2020-03-21_at_10.57.43_AM.png','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (289,'2020-10-29 19:32:52.304567','7','/media/upload_files/medical_supply_us_catalogue_L74oP7b.indd','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (290,'2020-10-29 19:32:52.328688','6','/media/upload_files/medical_supply_us_catalogue.indd','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (291,'2020-10-29 19:32:52.352783','5','/media/upload_files/medical_supply_us_catalogue.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (292,'2020-10-29 19:32:52.375113','4','/media/upload_files/background.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (293,'2020-10-29 19:32:52.402075','3','/media/upload_files/Face_Mask_v0sara-02.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (294,'2020-10-29 19:32:52.422244','2','/media/upload_files/WhatsApp_Image_2019-11-14_at_11.34.38_AM_WPtVyBS.jpg','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (295,'2020-10-29 19:32:52.445114','1','/media/upload_files/OM12JN1.eps.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (296,'2020-10-29 20:03:06.217307','1','/media/upload_files/078_What_is_Vuex.en.srt','[{"changed": {"fields": ["User", "Patient"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (297,'2020-10-29 20:03:11.397800','1','/media/upload_files/078_What_is_Vuex.en.srt','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (298,'2020-10-30 05:01:58.998220','1','/media/upload_files/078_What_is_Vuex.en.srt','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (299,'2020-10-30 05:06:11.987782','1','/media/upload_files/081_Import_Action_in_Product_Page.en_4sjz0mY.srt','[{"changed": {"fields": ["User"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (300,'2020-10-30 05:20:17.088529','1','Diar Salim - 2020-11-06 16:30:00+00:00','',18,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (301,'2020-10-30 05:20:23.257046','2','Sakar Abdulla - 2020-10-13 16:58:00+00:00','',18,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (302,'2020-11-01 19:21:30.007335','11','/media/upload_files/Lox_Cover-02.jpg','[{"changed": {"fields": ["File type"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (303,'2020-11-01 19:21:37.109745','9','/media/upload_files/Lox_CataloguePrint.pdf','[{"changed": {"fields": ["File type"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (304,'2020-11-01 19:21:41.305768','7','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_7VOX71U.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (305,'2020-11-01 19:21:45.282785','5','/media/upload_files/Downtown_Sarchinar_4OBCs7E.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (306,'2020-11-01 19:21:48.077934','13','/media/upload_files/Fig_Plus_Logo_V01-01.jpg','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (307,'2020-11-01 19:21:51.189917','12','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_HZIj22g.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (308,'2020-11-01 19:21:53.639934','11','/media/upload_files/Lox_Cover-02.jpg','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (309,'2020-11-01 19:21:59.538866','10','/media/upload_files/lox_logo.png','[{"changed": {"fields": ["File type"]}}]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (310,'2020-11-01 19:22:06.609392','8','/media/upload_files/Fig_Plus_Logo_V01-01_SfOrqXk.jpg','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (311,'2020-11-01 19:22:12.155347','7','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_7VOX71U.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (312,'2020-11-01 19:22:17.142585','1','/media/upload_files/Fig_Plus_Logo_V01-01_5u4ayw5.jpg','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (313,'2020-11-01 19:22:20.672172','2','/media/upload_files/Mohammed_Ibrahim_Accounting_Report_-_20.08.17.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (314,'2020-11-01 19:22:24.262493','3','/media/upload_files/Mohammed_Ibrahim_Accounting_Report_-_20.08.17_s3oCuis.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (315,'2020-11-01 19:22:28.034128','4','/media/upload_files/figs_mask-02-02_Sp2mLXR.jpg','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (316,'2020-11-01 19:22:31.968945','5','/media/upload_files/Downtown_Sarchinar_4OBCs7E.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (317,'2020-11-01 19:22:36.377206','6','/media/upload_files/Fig_Plus_Logo_V01-01_Y5sUvZP.jpg','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (318,'2020-11-03 11:30:14.707457','51','/media/upload_files/TIC_MAGAZINE_-_V11_-_20.10.31.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (319,'2020-11-03 11:30:14.713482','50','/media/upload_files/TIC_PRINT_ooLYEVI.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (320,'2020-11-03 11:30:40.609847','36','/media/upload_files/TIC_MAGAZINE_-_V10_-_20.10.29_copy.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (321,'2020-11-03 11:30:40.615907','35','/media/upload_files/TIC_MAGAZINE_-_V09_-_20.10.25.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (322,'2020-11-03 11:46:52.916153','55','/media/upload_files/Positive_CoV_kvT1eNH.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (323,'2020-11-03 11:46:52.922121','54','/media/upload_files/PESHRAW-KArezawshk_-33-20_jAzXVdX.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (324,'2020-11-03 11:46:52.928121','53','/media/upload_files/LK.jpeg','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (325,'2020-11-03 11:46:52.934122','52','/media/upload_files/Lox_Cover-02_njG5o5S.jpg','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (326,'2020-11-03 11:46:52.939121','49','/media/upload_files/AXIS_-_Qirga_-_20-20_XnQlms1.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (327,'2020-11-03 11:46:52.944121','48','/media/upload_files/Capture_-_Domain_Expired_QFJSaJS.JPG','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (328,'2020-11-03 11:46:52.950147','47','/media/upload_files/Capture_zheer_yQQB8xd.JPG','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (329,'2020-11-03 11:46:52.956138','46','/media/upload_files/SWIFT.jpeg','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (330,'2020-11-03 11:46:52.961146','45','/media/upload_files/Capture_BB_JfktO64.JPG','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (331,'2020-11-03 11:46:52.971145','44','/media/upload_files/Fig_72_-_MOIT_-_PROPOSAL_QNBnF9o.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (332,'2020-11-03 11:46:52.976148','43','/media/upload_files/Capture_zheer_XFpdo4a.JPG','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (333,'2020-11-03 11:46:52.982120','42','/media/upload_files/Capture_Omar_MPBDYdY.JPG','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (334,'2020-11-03 11:46:52.987124','41','/media/upload_files/Fig_71_-_Majidi_Mall_-Rezan_Permistion_B922aln.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (335,'2020-11-03 11:46:52.992123','40','/media/upload_files/Gabriel-Capture_oW5c2gT.JPG','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (336,'2020-11-03 11:46:52.997121','39','/media/upload_files/Capture_Omar_JbA9Fd3.JPG','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (337,'2020-11-03 11:46:53.002121','38','/media/upload_files/roza-barcode_mTpfZYm.JPG','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (338,'2020-11-03 11:46:53.007121','37','/media/upload_files/roza-barcode.JPG','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (339,'2020-11-03 11:46:53.012120','34','/media/upload_files/Lox_Cover-02_E9dZAa8.jpg','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (340,'2020-11-03 11:46:53.016122','33','/media/upload_files/AXIS_-_Qirga_-_20-20_Ealktua.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (341,'2020-11-03 11:46:53.021122','32','/media/upload_files/PESHRAW-KArezawshk_-33-20.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (342,'2020-11-03 11:46:53.026123','31','/media/upload_files/Positive_CoV_BvPBY35.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (343,'2020-11-03 11:46:53.031124','30','/media/upload_files/TIC_PRINT_96Pbmd8.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (344,'2020-11-03 11:46:53.036121','29','/media/upload_files/Plans_for_documenting_of_Building_Power_Plant_in_Kalar.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (345,'2020-11-03 11:46:53.041125','28','/media/upload_files/AXIS_-_Qirga_-_20-20_wrmsE8b.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (346,'2020-11-03 11:46:53.045122','27','/media/upload_files/Slemani_Govt_-_4374-20_-_20.07.27.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (347,'2020-11-03 11:46:53.050122','26','/media/upload_files/Positive_CoV_MqS8FF0.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (348,'2020-11-03 11:46:53.056121','25','/media/upload_files/Positive_CoV.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (349,'2020-11-03 11:46:53.060122','24','/media/upload_files/TIC_PRINT_tLt2gK7.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (350,'2020-11-03 11:46:53.065122','23','/media/upload_files/TIC_PRINT_EXwULKz.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (351,'2020-11-03 11:46:53.070123','22','/media/upload_files/TIC_PRINT.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (352,'2020-11-03 11:46:53.074121','21','/media/upload_files/Fig_72_-_MOIT_-_PROPOSAL.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (353,'2020-11-03 11:46:53.079122','20','/media/upload_files/444_6XtZh2E.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (354,'2020-11-03 11:46:53.083122','19','/media/upload_files/444_JsxVguX.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (355,'2020-11-03 11:46:53.088122','18','/media/upload_files/444_ZOjxBfb.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (356,'2020-11-03 11:46:53.093124','17','/media/upload_files/444_wJSO7XX.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (357,'2020-11-03 11:46:53.102121','16','/media/upload_files/444_x16Lkao.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (358,'2020-11-03 11:46:53.106121','15','/media/upload_files/444_qb2duN1.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (359,'2020-11-03 11:46:53.111122','14','/media/upload_files/444.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (360,'2020-11-03 11:46:53.116122','13','/media/upload_files/Fig_Plus_Logo_V01-01.jpg','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (361,'2020-11-03 11:46:53.121121','12','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_HZIj22g.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (362,'2020-11-03 11:46:53.125121','11','/media/upload_files/Lox_Cover-02.jpg','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (363,'2020-11-03 11:46:53.130123','10','/media/upload_files/lox_logo.png','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (364,'2020-11-03 11:46:53.135121','9','/media/upload_files/Lox_CataloguePrint.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (365,'2020-11-03 11:46:53.140129','8','/media/upload_files/Fig_Plus_Logo_V01-01_SfOrqXk.jpg','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (366,'2020-11-03 11:46:53.145123','7','/media/upload_files/Mohammed_Ibrahim_Administration_Report_-_20.08.20_7VOX71U.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (367,'2020-11-03 11:46:53.150123','6','/media/upload_files/Fig_Plus_Logo_V01-01_Y5sUvZP.jpg','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (368,'2020-11-03 11:46:53.154122','5','/media/upload_files/Downtown_Sarchinar_4OBCs7E.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (369,'2020-11-03 11:46:53.159121','4','/media/upload_files/figs_mask-02-02_Sp2mLXR.jpg','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (370,'2020-11-03 11:46:53.166121','3','/media/upload_files/Mohammed_Ibrahim_Accounting_Report_-_20.08.17_s3oCuis.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (371,'2020-11-03 11:46:53.171121','2','/media/upload_files/Mohammed_Ibrahim_Accounting_Report_-_20.08.17.pdf','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (372,'2020-11-03 11:46:53.176122','1','/media/upload_files/Fig_Plus_Logo_V01-01_5u4ayw5.jpg','',14,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (373,'2020-11-03 11:47:26.686667','72','Sakar Abdulla - 2020-11-03 11:31:23.873935+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (374,'2020-11-03 11:47:26.700667','71','Sakar Abdulla - 2020-11-03 10:45:13.155062+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (375,'2020-11-03 11:47:26.708666','70','Sakar Abdulla - 2020-11-03 09:01:16.572520+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (376,'2020-11-03 11:47:26.714670','69','Kamaran abaka - 2020-11-03 08:55:51.026189+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (377,'2020-11-03 11:47:26.723665','68','Kamaran abaka - 2020-11-03 08:55:37.109171+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (378,'2020-11-03 11:47:26.729668','67','Kamaran abaka - 2020-11-03 08:53:06.576659+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (379,'2020-11-03 11:47:26.734667','66','Kamaran abaka - 2020-11-03 08:52:37.582363+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (380,'2020-11-03 11:47:26.740667','65','Kamaran abaka - 2020-11-03 08:51:23.752074+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (381,'2020-11-03 11:47:26.745666','64','Kamaran abaka - 2020-11-03 08:43:31.061570+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (382,'2020-11-03 11:47:26.750667','63','Kamaran abaka - 2020-11-03 08:42:25.936356+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (383,'2020-11-03 11:47:26.755665','62','Kamaran abaka - 2020-11-03 08:37:17.630901+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (384,'2020-11-03 11:47:26.760667','61','Kamaran abaka - 2020-11-03 08:35:34.646923+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (385,'2020-11-03 11:47:26.765667','60','Kamaran abaka - 2020-11-03 08:28:26.967146+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (386,'2020-11-03 11:47:26.771666','59','Kamaran abaka - 2020-11-03 08:25:37.776438+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (387,'2020-11-03 11:47:26.775669','58','Kamaran abaka - 2020-11-03 08:23:33.598635+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (388,'2020-11-03 11:47:26.780667','57','Kamaran abaka - 2020-11-03 08:21:42.519890+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (389,'2020-11-03 11:47:26.785667','56','Kamaran abaka - 2020-11-03 07:54:07.709278+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (390,'2020-11-03 11:47:26.790665','55','Kamaran abaka - 2020-11-03 07:47:01.699183+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (391,'2020-11-03 11:47:26.795667','54','Kamaran abaka - 2020-11-03 07:46:49.924868+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (392,'2020-11-03 11:47:26.800666','53','Kamaran abaka - 2020-11-03 07:31:24.195118+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (393,'2020-11-03 11:47:26.805666','52','Kamaran abaka - 2020-11-03 07:31:10.616506+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (394,'2020-11-03 11:47:26.809667','51','Kamaran abaka - 2020-11-03 07:30:04.074253+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (395,'2020-11-03 11:47:26.814668','50','Kamaran abaka - 2020-11-03 07:29:49.889355+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (396,'2020-11-03 11:47:26.820665','49','Kamaran abaka - 2020-11-03 07:25:47.655972+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (397,'2020-11-03 11:47:26.824667','48','Kamaran abaka - 2020-11-03 07:23:47.669060+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (398,'2020-11-03 11:47:26.829666','47','Kamaran abaka - 2020-11-03 07:18:14.061142+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (399,'2020-11-03 11:47:26.834665','46','Kamaran abaka - 2020-11-03 07:06:30.643458+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (400,'2020-11-03 11:47:26.839666','45','Kamaran abaka - 2020-11-03 07:06:02.493867+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (401,'2020-11-03 11:47:26.844667','44','Kamaran abaka - 2020-11-03 06:55:05.887996+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (402,'2020-11-03 11:47:26.853667','43','Sazgar Rashid - 2020-11-03 06:45:21.264165+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (403,'2020-11-03 11:47:26.858667','42','Kamaran abaka - 2020-11-03 06:30:09.556481+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (404,'2020-11-03 11:47:26.863667','41','Kamaran abaka - 2020-11-03 06:29:22.317549+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (405,'2020-11-03 11:47:26.868668','40','Dana Ahmed - 2020-10-30 05:15:53.338632+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (406,'2020-11-03 11:47:26.873665','39','Dana Ahmed - 2020-10-29 19:26:23.917038+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (407,'2020-11-03 11:47:26.878666','38','Dana Ahmed - 2020-10-29 19:24:48.937246+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (408,'2020-11-03 11:47:26.883667','37','Rozhgar Anwar - 2020-10-29 06:36:55.917612+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (409,'2020-11-03 11:47:26.888665','36','Diar Salim - 2020-10-27 11:37:28.973843+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (410,'2020-11-03 11:47:26.893667','33','Sakar Abdulla - 2020-10-24 12:48:37.014836+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (411,'2020-11-03 11:47:26.898668','32','Sakar Abdulla - 2020-10-24 12:32:13.868910+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (412,'2020-11-03 11:47:26.903680','31','Sakar Abdulla - 2020-10-24 12:31:54.624339+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (413,'2020-11-03 11:47:26.908698','30','Nariman Baban - 2020-10-24 11:51:14.428379+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (414,'2020-11-03 11:47:26.913696','29','Nariman Baban - 2020-10-24 11:49:33.663931+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (415,'2020-11-03 11:47:26.918701','28','Nariman Baban - 2020-10-24 10:58:35.306365+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (416,'2020-11-03 11:47:26.926667','27','Nariman Baban - 2020-10-24 08:47:59.593088+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (417,'2020-11-03 11:47:26.931668','26','Nariman Baban - 2020-10-24 08:45:32.896242+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (418,'2020-11-03 11:47:26.936698','25','Nariman Baban - 2020-10-24 08:37:43.193563+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (419,'2020-11-03 11:47:26.941668','24','Sakar Abdulla - 2020-10-24 07:35:14.866114+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (420,'2020-11-03 11:47:26.947666','23','Sakar Abdulla - 2020-10-24 07:30:07.879748+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (421,'2020-11-03 11:47:26.953665','22','Rozhgar Anwar - 2020-10-24 07:16:46.657659+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (422,'2020-11-03 11:47:26.961667','21','Sakar Abdulla - 2020-10-22 20:22:57.063590+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (423,'2020-11-03 11:47:26.966695','20','Rozhgar Anwar - 2020-10-17 06:12:57.204200+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (424,'2020-11-03 11:47:26.971701','12','Khalid Chawtani - 2020-10-16 09:21:05.212302+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (425,'2020-11-03 11:47:26.977666','10','Rawand Najmadin - 2020-10-16 07:28:27.690731+00:00','',15,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (426,'2020-11-03 11:48:46.509549','56','/media/upload_files/Positive_CoV.pdf','[{"added": {}}]',14,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (427,'2020-11-03 11:49:09.414358','57','/media/upload_files/Fig_72_-_MOIT_-_PROPOSAL.pdf','[{"added": {}}]',14,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (428,'2020-11-03 11:49:37.740824','58','/media/upload_files/Slemani_Govt_-_4374-20_-_20.07.27.pdf','[{"added": {}}]',14,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (429,'2020-11-03 11:49:47.681141','73','Dana Ahmed - 2020-11-03 11:49:47.679113+00:00','[{"added": {}}]',15,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (430,'2020-11-03 12:09:33.841636','59','/media/upload_files/AXIS_-_Qirga_-_20-20.pdf','[{"added": {}}]',14,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (431,'2020-11-03 12:09:37.403133','73','Dana Ahmed - 2020-11-03 11:49:47.679113+00:00','[{"changed": {"fields": ["Files"]}}]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (432,'2020-11-03 12:45:39.894485','61','/media/upload_files/Lox_Cover-02.jpg','[{"added": {}}]',14,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (433,'2020-11-03 12:45:57.864413','62','/media/upload_files/Gabriel-Capture.JPG','[{"added": {}}]',14,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (434,'2020-11-03 12:46:15.881453','63','/media/upload_files/Capture_zheer.JPG','[{"added": {}}]',14,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (435,'2020-11-03 12:46:17.659960','73','Dana Ahmed - 2020-11-03 11:49:47.679113+00:00','[{"changed": {"fields": ["Files"]}}]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (436,'2020-11-03 13:23:51.879896','57','/media/upload_files/Fig_72_-_MOIT_-_PROPOSAL_wF08UCi.pdf','[{"changed": {"fields": ["File"]}}]',14,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (437,'2020-11-03 13:24:22.663752','56','/media/upload_files/Positive_CoV_gR3R0D5.pdf','[{"changed": {"fields": ["File"]}}]',14,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (438,'2020-11-04 17:05:13.363367','65','/media/upload_files/Final_Banner_r8iRb4q.jpg','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (439,'2020-11-04 17:05:17.871577','76','Kamaran abaka - 2020-11-04 17:05:17.859127+00:00','[{"added": {}}]',15,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (440,'2020-11-06 10:33:59.368826','66','/media/upload_files/dental_wTQOLtK.pdf','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (441,'2020-11-06 11:55:31.188515','66','/media/upload_files/dental_wTQOLtK.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (442,'2020-11-06 11:55:43.102192','66','/media/upload_files/dental_wTQOLtK.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (443,'2020-11-06 11:56:02.258277','67','/media/upload_files/21299_EtqzR93.pdf','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (444,'2020-11-06 11:56:06.506980','67','/media/upload_files/21299_EtqzR93.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (445,'2020-11-06 11:56:30.919210','67','/media/upload_files/21299_EtqzR93.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (446,'2020-11-06 12:18:28.508655','68','/media/upload_files/dental_gG9mqgF.pdf','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (447,'2020-11-06 12:18:30.452488','68','/media/upload_files/dental_gG9mqgF.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (448,'2020-11-06 12:18:57.752184','69','/media/upload_files/dental_M965998.pdf','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (449,'2020-11-06 12:34:11.526267','69','/media/upload_files/dental_M965998.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (450,'2020-11-06 12:34:11.550680','68','/media/upload_files/dental_gG9mqgF.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (451,'2020-11-06 12:34:11.574115','67','/media/upload_files/21299_EtqzR93.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (452,'2020-11-06 12:34:11.597306','66','/media/upload_files/dental_wTQOLtK.pdf','',14,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (453,'2020-11-06 12:34:17.812163','56','/media/upload_files/Positive_CoV_gR3R0D5.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (454,'2020-11-06 12:34:20.015892','56','/media/upload_files/Positive_CoV_gR3R0D5.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (455,'2020-11-06 12:35:29.691930','57','/media/upload_files/Fig_72_-_MOIT_-_PROPOSAL_wF08UCi.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (456,'2020-11-06 12:35:31.282372','57','/media/upload_files/Fig_72_-_MOIT_-_PROPOSAL_wF08UCi.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (457,'2020-11-06 12:35:36.883547','58','/media/upload_files/Slemani_Govt_-_4374-20_-_20.07.27.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (458,'2020-11-06 12:35:42.123407','59','/media/upload_files/AXIS_-_Qirga_-_20-20.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (459,'2020-11-06 12:35:47.008850','60','/media/upload_files/LK.pdf','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (460,'2020-11-06 12:35:53.942637','61','/media/upload_files/Lox_Cover-02.jpg','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (461,'2020-11-06 12:35:55.473059','61','/media/upload_files/Lox_Cover-02.jpg','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (462,'2020-11-06 12:36:04.826410','62','/media/upload_files/Gabriel-Capture.JPG','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (463,'2020-11-06 12:36:12.934533','63','/media/upload_files/Capture_zheer.JPG','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (464,'2020-11-06 12:36:17.551133','65','/media/upload_files/Final_Banner_r8iRb4q.jpg','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (465,'2020-11-06 12:36:21.055204','64','/media/upload_files/Capture_BB.JPG','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (466,'2020-11-06 12:36:26.061984','63','/media/upload_files/Capture_zheer.JPG','[]',14,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (467,'2020-11-07 17:07:43.345720','77','Maka Khalid - 2020-11-07 17:07:43.343702+00:00','[{"added": {}}]',15,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (468,'2020-11-07 17:13:22.731453','70','/media/upload_files/Downtown_Sarchinar_kRARu1L.pdf','[{"added": {}}]',14,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (469,'2020-11-07 17:13:55.799634','71','/media/upload_files/06-10-06smile_16O8DDW.jpg','[{"added": {}}]',14,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (470,'2020-11-07 17:14:00.950621','77','Maka Khalid - 2020-11-07 17:07:43.343702+00:00','[{"changed": {"fields": ["Files"]}}]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (471,'2020-11-07 17:25:07.211919','7','Rawa Jamal - 2020-11-20 19:12:00+00:00','[{"changed": {"fields": ["Date"]}}]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (472,'2020-11-07 17:25:16.212560','6','Kamaran abaka - 2020-11-15 01:49:00+00:00','[{"changed": {"fields": ["Date"]}}]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (473,'2020-11-07 17:25:23.964604','4','Dana Ahmed - 2020-11-16 10:25:00+00:00','[{"changed": {"fields": ["Date"]}}]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (474,'2020-11-07 17:25:32.340645','5','Nariman Baban - 2020-11-26 10:25:00+00:00','[{"changed": {"fields": ["Date"]}}]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (475,'2020-11-09 14:18:00.007777','12','Maka Khalid - 2020-11-10 14:17:58','[{"added": {}}]',18,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (476,'2020-11-09 14:18:15.427351','13','Rawa Jamal - 2020-11-09 14:18:14','[{"added": {}}]',18,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (477,'2020-11-10 10:14:01.757629','22','Nawroz Khafaf','[{"changed": {"fields": ["Email"]}}]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (478,'2020-11-10 17:48:59.467623','33','Dana Ahmed','[{"changed": {"fields": ["Image"]}}]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (479,'2020-11-10 17:54:17.224274','33','Dana Ahmed','[{"changed": {"fields": ["Image"]}}]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (480,'2020-11-13 00:01:29.845311','1','Dana Ahmed - 2020-11-13 00:01:29.842320','[{"added": {}}]',19,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (481,'2020-11-15 13:01:40.892645','1','Dana Ahmed - 2020-11-13 00:01:29.842320','[{"changed": {"fields": ["Oral hygiene"]}}]',19,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (482,'2020-11-16 19:10:01.187434','34','Maka Khalid','[]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (483,'2020-11-16 19:14:31.156836','2','Maka Khalid - 2020-11-16 19:14:31.148786','[{"added": {}}]',19,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (484,'2020-11-16 21:39:41.148710','3','Lionel Richie - 2020-11-16 21:39:41.143342','[{"added": {}}]',19,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (485,'2020-11-16 21:39:48.896133','4','Sumaya Tahir - 2020-11-16 21:39:48.896133','[{"added": {}}]',19,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (486,'2020-11-17 14:03:48.961846','5','Khalid Chawtani','[]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (487,'2020-11-17 14:03:54.321852','9','Rawand Najmadin','[]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (488,'2020-11-17 14:03:59.899390','37','Ilham Shakir','[{"changed": {"fields": ["Status"]}}]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (489,'2020-11-18 15:22:31.451033','1','Barham Hassan - 2020-11-18 15:22:31.449028','[{"added": {}}]',20,4,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (490,'2020-11-18 19:09:14.071720','41','Hamay Nergiz','[]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (491,'2020-11-18 21:00:24.044410','33','Dana Ahmed','[]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (492,'2020-11-18 21:08:43.348225','44','Taylor Swift','[{"changed": {"fields": ["Status"]}}]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (493,'2020-11-18 21:09:17.602984','44','Taylor Swift','[{"changed": {"fields": ["Status"]}}]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (494,'2020-11-20 21:52:17.572083','26','Sakar Abdulla','[]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (495,'2020-11-24 20:27:17.314144','73','Dana Ahmed - 2020-11-03 11:49:47.679113','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (496,'2020-11-24 20:27:22.250059','74','Dana Ahmed - 2020-11-04 10:56:13.993607','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (497,'2020-11-24 20:27:28.193488','75','Dana Ahmed - 2020-11-04 10:56:32.498464','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (498,'2020-11-24 20:27:33.542109','76','Kamaran abaka - 2020-11-04 17:05:17.859127','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (499,'2020-11-24 20:27:39.579041','77','Maka Khalid - 2020-11-07 17:07:43.343702','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (500,'2020-11-24 20:27:44.346911','78','Maka Khalid - 2020-11-07 17:15:26.795993','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (501,'2020-11-24 20:27:49.872991','79','Nancy Pelosi - 2020-11-21 15:02:40.900094','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (502,'2020-11-24 20:27:54.972568','80','Nancy Pelosi - 2020-11-21 15:03:28.763210','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (503,'2020-11-24 20:28:01.064510','81','Nancy Pelosi - 2020-11-21 15:08:28.316792','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (504,'2020-11-24 20:28:05.729854','82','Qubad Talabani - 2020-11-21 20:52:14.199300','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (505,'2020-11-24 20:28:09.815376','83','Ibrahim Tatlises - 2020-11-21 20:55:19.865129','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (506,'2020-11-24 20:28:14.163986','84','Hamay Nergiz - 2020-11-21 21:46:33.497995','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (507,'2020-11-24 20:28:18.155688','85','Lionel Richie - 2020-11-21 21:54:22.448913','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (508,'2020-11-24 20:28:21.882105','86','Taylor Swift - 2020-11-22 10:18:16.852498','[]',15,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (509,'2020-11-27 15:46:18.150199','52','Truman Carry','[]',11,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (510,'2020-11-27 15:57:13.178759','60','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (511,'2020-11-27 15:57:13.195714','59','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (512,'2020-11-27 15:57:13.214661','58','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (513,'2020-11-27 15:57:13.233612','57','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (514,'2020-11-27 15:57:13.249571','56','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (515,'2020-11-27 15:57:13.267523','55','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (516,'2020-11-27 15:57:13.291460','54','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (517,'2020-11-27 15:57:13.310409','53','Jim Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (518,'2020-11-27 15:57:13.327363','52','Truman Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (519,'2020-11-27 15:57:13.347308','51','Jenna Truman','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (520,'2020-11-27 15:57:13.365262','50','Harry Potter','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (521,'2020-11-27 15:57:13.385208','49','Harry Potter','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (522,'2020-11-28 12:19:44.726607','126','Lucy Mayers','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (523,'2020-11-28 12:19:44.731735','125','Lucy Mayers','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (524,'2020-11-28 12:19:44.736640','124','Lucy Mayers','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (525,'2020-11-28 12:19:44.741634','123','Lucy Mayers','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (526,'2020-11-28 12:19:44.747607','122','Lucy Mayers','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (527,'2020-11-28 12:19:44.752605','121','Lucy Mayers','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (528,'2020-11-28 12:19:44.758615','120','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (529,'2020-11-28 12:19:44.766611','119','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (530,'2020-11-28 12:19:44.771644','118','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (531,'2020-11-28 12:19:44.776636','117','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (532,'2020-11-28 12:19:44.782606','116','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (533,'2020-11-28 12:19:44.786687','115','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (534,'2020-11-28 12:19:44.792739','114','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (535,'2020-11-28 12:19:44.796943','113','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (536,'2020-11-28 12:19:44.801934','112','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (537,'2020-11-28 12:19:44.806970','111','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (538,'2020-11-28 12:19:44.811934','110','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (539,'2020-11-28 12:19:44.820935','109','Mahesh garry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (540,'2020-11-28 12:19:44.824991','108','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (541,'2020-11-28 12:19:44.829991','107','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (542,'2020-11-28 12:19:44.835033','106','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (543,'2020-11-28 12:19:44.839033','105','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (544,'2020-11-28 12:19:44.844048','104','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (545,'2020-11-28 12:19:44.849177','103','Test Carry','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (546,'2020-11-28 12:19:44.854176','102','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (547,'2020-11-28 12:19:44.858177','101','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (548,'2020-11-28 12:19:44.866177','100','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (549,'2020-11-28 12:19:44.872178','99','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (550,'2020-11-28 12:19:44.881369','98','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (551,'2020-11-28 12:19:44.887441','97','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (552,'2020-11-28 12:19:44.893432','96','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (553,'2020-11-28 12:19:44.897434','95','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (554,'2020-11-28 12:19:44.903434','94','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (555,'2020-11-28 12:19:44.907442','93','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (556,'2020-11-28 12:19:44.912471','92','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (557,'2020-11-28 12:19:44.920497','91','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (558,'2020-11-28 12:19:44.925518','90','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (559,'2020-11-28 12:19:44.930544','89','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (560,'2020-11-28 12:19:44.935544','88','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (561,'2020-11-28 12:19:44.943544','87','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (562,'2020-11-28 12:19:44.949572','86','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (563,'2020-11-28 12:19:44.956544','85','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (564,'2020-11-28 12:19:44.961544','84','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (565,'2020-11-28 12:19:44.966544','83','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (566,'2020-11-28 12:19:44.971543','82','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (567,'2020-11-28 12:19:44.976543','81','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (568,'2020-11-28 12:19:44.981544','80','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (569,'2020-11-28 12:19:44.986545','79','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (570,'2020-11-28 12:19:44.990544','78','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (571,'2020-11-28 12:19:44.995571','77','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (572,'2020-11-28 12:19:45.000572','76','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (573,'2020-11-28 12:19:45.006543','75','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (574,'2020-11-28 12:19:45.011569','74','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (575,'2020-11-28 12:19:45.016569','73','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (576,'2020-11-28 12:19:45.022544','72','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (577,'2020-11-28 12:19:45.027568','71','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (578,'2020-11-28 12:19:45.032544','70','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (579,'2020-11-28 12:19:45.037544','69','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (580,'2020-11-28 12:19:45.046545','68','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (581,'2020-11-28 12:19:45.052545','67','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (582,'2020-11-28 12:19:45.056545','66','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (583,'2020-11-28 12:19:45.061545','65','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (584,'2020-11-28 12:19:45.066544','64','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (585,'2020-11-28 12:19:45.071547','63','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (586,'2020-11-28 12:19:45.076543','62','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (587,'2020-11-28 12:19:45.081545','61','Test Alert','',11,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (588,'2020-12-04 14:22:04.816032','16','Qubad Talabani - 2021-02-16 20:44:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (589,'2020-12-04 15:08:42.455934','16','Qubad Talabani - 2021-02-16 20:44:00','[{"changed": {"fields": ["Date to"]}}]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (590,'2020-12-04 15:08:51.017205','17','Lionel Richie - 2020-12-12 15:00:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (591,'2020-12-04 15:09:01.428970','17','Lionel Richie - 2020-12-12 15:00:00','[{"changed": {"fields": ["Date to"]}}]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (592,'2020-12-04 15:09:03.333542','17','Lionel Richie - 2020-12-12 15:00:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (593,'2020-12-04 15:09:12.701706','17','Lionel Richie - 2020-12-12 15:00:00','[{"changed": {"fields": ["Date to"]}}]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (594,'2020-12-04 15:09:18.113725','17','Lionel Richie - 2020-12-12 15:00:00','[{"changed": {"fields": ["Date to"]}}]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (595,'2020-12-04 15:09:19.013326','17','Lionel Richie - 2020-12-12 15:00:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (596,'2020-12-04 15:09:35.841227','9','Azad Mina - 2020-10-17 16:14:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (597,'2020-12-04 15:09:41.525808','11','Rozhgar Anwar - 2020-11-04 16:19:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (598,'2020-12-04 15:09:46.466781','10','Nawroz Khafaf - 2020-11-05 16:18:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (599,'2020-12-04 15:09:50.801436','8','Diar Salim - 2020-11-06 16:14:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (600,'2020-12-04 15:09:54.827504','13','Rawa Jamal - 2020-11-09 14:18:14','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (601,'2020-12-04 15:10:00.127667','12','Maka Khalid - 2020-11-10 14:17:58','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (602,'2020-12-04 15:10:07.229034','6','Kamaran abaka - 2020-11-15 01:49:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (603,'2020-12-04 15:10:11.015299','4','Dana Ahmed - 2020-11-16 10:25:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (604,'2020-12-04 15:10:14.886284','5','Nariman Baban - 2020-11-16 10:25:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (605,'2020-12-04 15:10:26.111689','18','Nancy Pelosi - 2020-11-19 02:00:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (606,'2020-12-04 15:10:30.532498','7','Rawa Jamal - 2020-11-20 19:12:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (607,'2020-12-04 15:10:34.889615','20','Lucy Mayers - 2020-11-30 00:00:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (608,'2020-12-04 15:10:41.313323','14','Nancy Pelosi - 2020-11-30 03:38:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (609,'2020-12-04 15:10:49.996647','14','Nancy Pelosi - 2020-11-30 03:38:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (610,'2020-12-04 15:10:55.268418','23','Nancy Pelosi - 2020-11-30 04:45:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (611,'2020-12-04 15:10:59.383831','21','Lucy Mayers - 2020-11-30 15:15:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (612,'2020-12-04 15:11:03.333531','25','Ibrahim Tatlises - 2020-12-04 18:30:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (613,'2020-12-04 15:11:07.517170','26','Hamay Nergiz - 2020-12-05 14:20:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (614,'2020-12-04 15:14:20.328731','27','Ibrahim Tatlises - 2020-12-03 14:20:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (615,'2020-12-04 15:14:25.752393','21','Lucy Mayers - 2020-11-30 15:15:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (616,'2020-12-04 15:14:30.970746','22','Lucy Mayers - 2020-12-03 16:30:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (617,'2020-12-04 15:14:34.663495','25','Ibrahim Tatlises - 2020-12-04 18:30:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (618,'2020-12-04 15:14:38.064100','26','Hamay Nergiz - 2020-12-05 14:20:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (619,'2020-12-04 15:14:41.830632','28','Taylor Swift - 2020-12-05 16:20:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (620,'2020-12-04 15:14:46.847472','29','Barham Hassan - 2020-12-06 13:20:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (621,'2020-12-04 15:14:50.227783','26','Hamay Nergiz - 2020-12-05 14:20:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (622,'2020-12-04 15:14:55.431620','29','Barham Hassan - 2020-12-06 13:20:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (623,'2020-12-04 15:14:58.540112','15','Ibrahim Tatlises - 2020-12-09 01:40:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (624,'2020-12-04 15:15:03.542564','19','Dana Ahmed - 2020-12-11 21:10:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (625,'2020-12-04 15:15:06.634625','17','Lionel Richie - 2020-12-12 15:00:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (626,'2020-12-04 15:15:09.115143','15','Ibrahim Tatlises - 2020-12-09 01:40:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (627,'2020-12-04 15:25:42.490346','22','Lucy Mayers - 2020-12-03 16:30:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (628,'2020-12-04 15:26:52.101731','19','Dana Ahmed - 2020-12-11 21:10:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (629,'2020-12-04 15:27:09.023681','25','Ibrahim Tatlises - 2020-12-04 18:30:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (630,'2020-12-04 15:27:11.581841','26','Hamay Nergiz - 2020-12-05 14:20:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (631,'2020-12-04 15:27:14.329790','28','Taylor Swift - 2020-12-05 16:20:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (632,'2020-12-04 15:27:16.738466','29','Barham Hassan - 2020-12-06 13:20:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (633,'2020-12-04 15:27:18.900436','15','Ibrahim Tatlises - 2020-12-09 01:40:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (634,'2020-12-04 15:27:22.058622','17','Lionel Richie - 2020-12-12 15:00:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (635,'2020-12-04 15:27:25.094690','16','Qubad Talabani - 2021-02-16 20:44:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (636,'2020-12-04 15:27:59.356446','9','Azad Mina - 2020-10-17 16:14:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (637,'2020-12-04 15:28:01.960706','9','Azad Mina - 2020-10-17 16:14:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (638,'2020-12-04 15:28:04.245746','11','Rozhgar Anwar - 2020-11-04 16:19:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (639,'2020-12-04 15:28:06.223882','10','Nawroz Khafaf - 2020-11-05 16:18:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (640,'2020-12-04 15:28:08.095683','8','Diar Salim - 2020-11-06 16:14:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (641,'2020-12-04 15:28:10.480809','13','Rawa Jamal - 2020-11-09 14:18:14','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (642,'2020-12-04 15:28:12.390079','12','Maka Khalid - 2020-11-10 14:17:58','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (643,'2020-12-04 15:28:14.242577','6','Kamaran abaka - 2020-11-15 01:49:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (644,'2020-12-04 15:28:16.449912','4','Dana Ahmed - 2020-11-16 10:25:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (645,'2020-12-04 15:28:18.464920','5','Nariman Baban - 2020-11-16 10:25:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (646,'2020-12-04 15:28:21.468727','18','Nancy Pelosi - 2020-11-19 02:00:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (647,'2020-12-04 15:28:23.897596','7','Rawa Jamal - 2020-11-20 19:12:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (648,'2020-12-04 15:28:26.757308','20','Lucy Mayers - 2020-11-30 00:00:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (649,'2020-12-04 15:28:28.804608','14','Nancy Pelosi - 2020-11-30 03:38:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (650,'2020-12-04 15:28:30.915793','23','Nancy Pelosi - 2020-11-30 04:45:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (651,'2020-12-04 15:28:33.042445','21','Lucy Mayers - 2020-11-30 15:15:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (652,'2020-12-04 15:28:35.131705','27','Ibrahim Tatlises - 2020-12-03 14:20:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (653,'2020-12-04 15:28:38.725493','22','Lucy Mayers - 2020-12-03 16:30:00','[]',18,4,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (654,'2020-12-04 16:14:50.288886','16','Qubad Talabani - 2021-02-16 20:44:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (655,'2020-12-06 20:47:43.339951','115','Qubad Talabani - 2021-02-05 02:15:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (656,'2020-12-06 20:47:43.376433','95','Angelina Jolie - 2021-01-10 16:45:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (657,'2020-12-06 20:47:43.400497','96','Barham Hassan - 2021-01-07 03:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (658,'2020-12-06 20:47:43.426539','60','Lionel Richie - 2021-01-03 03:36:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (659,'2020-12-06 20:47:43.449002','61','Dana Ahmed - 2021-01-02 06:01:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (660,'2020-12-06 20:47:43.483907','68','Qubad Talabani - 2021-01-01 04:02:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (661,'2020-12-06 20:47:43.506606','62','Maka Khalid - 2020-12-29 02:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (662,'2020-12-06 20:47:43.536272','59','Lionel Richie - 2020-12-27 04:11:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (663,'2020-12-06 20:47:43.557950','58','Ilham Shakir - 2020-12-27 01:19:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (664,'2020-12-06 20:47:43.579141','156','Qubad Talabani - 2020-12-20 07:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (665,'2020-12-06 20:47:43.601272','153','Ibrahim Tatlises - 2020-12-18 03:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (666,'2020-12-06 20:47:43.620163','150','Hama Karim Khan - 2020-12-18 03:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (667,'2020-12-06 20:47:43.645247','152','Taylor Swift - 2020-12-18 02:15:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (668,'2020-12-06 20:47:43.664212','151','Qubad Talabani - 2020-12-18 02:15:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (669,'2020-12-06 20:47:43.687821','57','Sumaya Tahir - 2020-12-17 02:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (670,'2020-12-06 20:47:43.708411','102','Hamay Nergiz - 2020-12-14 07:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (671,'2020-12-06 20:47:43.728479','88','Taylor Swift - 2020-12-14 05:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (672,'2020-12-06 20:47:43.749285','87','Ibrahim Tatlises - 2020-12-14 03:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (673,'2020-12-06 20:47:43.769847','127','Taylor Swift - 2020-12-13 06:15:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (674,'2020-12-06 20:47:43.795155','155','Taylor Swift - 2020-12-13 06:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (675,'2020-12-06 20:47:43.817231','148','Taylor Swift - 2020-12-13 06:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (676,'2020-12-06 20:47:43.839570','144','Taylor Swift - 2020-12-13 06:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (677,'2020-12-06 20:47:43.860271','149','Taylor Swift - 2020-12-13 05:15:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (678,'2020-12-06 20:47:43.889543','146','Taylor Swift - 2020-12-13 05:15:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (679,'2020-12-06 20:47:43.920456','132','Sumaya Tahir - 2020-12-13 05:15:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (680,'2020-12-06 20:47:43.944829','125','Taylor Swift - 2020-12-13 05:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (681,'2020-12-06 20:47:43.969754','119','Nancy Pelosi - 2020-12-13 05:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (682,'2020-12-06 20:47:43.996913','56','Angelina Jolie - 2020-12-13 03:11:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (683,'2020-12-06 20:47:44.019379','126','Michael B. Jordan - 2020-12-13 03:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (684,'2020-12-06 20:47:44.045046','124','Lucy Mayers - 2020-12-13 02:15:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (685,'2020-12-06 20:47:44.093295','141','Qubad Talabani - 2020-12-13 01:00:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (686,'2020-12-06 20:47:44.113262','45','Ilham Shakir - 2020-12-13 00:20:00','',18,4,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (687,'2020-12-06 20:47:44.150257','17','Lionel Richie - 2020-12-12 12:45:00','',18,4,3);
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (13,4,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (14,4,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (15,4,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (16,4,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (17,5,'add_session','Can add session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (18,5,'change_session','Can change session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (19,5,'delete_session','Can delete session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (20,5,'view_session','Can view session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (21,6,'add_user','Can add user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (22,6,'change_user','Can change user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (23,6,'delete_user','Can delete user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (24,6,'view_user','Can view user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (25,7,'add_address','Can add address');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (26,7,'change_address','Can change address');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (27,7,'delete_address','Can delete address');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (28,7,'view_address','Can view address');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (29,8,'add_doctor','Can add doctor');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (30,8,'change_doctor','Can change doctor');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (31,8,'delete_doctor','Can delete doctor');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (32,8,'view_doctor','Can view doctor');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (33,9,'add_timetable','Can add timetable');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (34,9,'change_timetable','Can change timetable');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (35,9,'delete_timetable','Can delete timetable');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (36,9,'view_timetable','Can view timetable');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (37,10,'add_schedule','Can add schedule');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (38,10,'change_schedule','Can change schedule');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (39,10,'delete_schedule','Can delete schedule');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (40,10,'view_schedule','Can view schedule');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (41,11,'add_patient','Can add patient');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (42,11,'change_patient','Can change patient');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (43,11,'delete_patient','Can delete patient');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (44,11,'view_patient','Can view patient');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (45,12,'add_appointment','Can add appointment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (46,12,'change_appointment','Can change appointment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (47,12,'delete_appointment','Can delete appointment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (48,12,'view_appointment','Can view appointment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (49,13,'add_currentpatients','Can add current patients');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (50,13,'change_currentpatients','Can change current patients');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (51,13,'delete_currentpatients','Can delete current patients');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (52,13,'view_currentpatients','Can view current patients');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (53,14,'add_attachment','Can add attachment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (54,14,'change_attachment','Can change attachment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (55,14,'delete_attachment','Can delete attachment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (56,14,'view_attachment','Can view attachment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (57,15,'add_treatment','Can add treatment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (58,15,'change_treatment','Can change treatment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (59,15,'delete_treatment','Can delete treatment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (60,15,'view_treatment','Can view treatment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (61,16,'add_token','Can add Token');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (62,16,'change_token','Can change Token');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (63,16,'delete_token','Can delete Token');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (64,16,'view_token','Can view Token');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (65,17,'add_tokenproxy','Can add token');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (66,17,'change_tokenproxy','Can change token');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (67,17,'delete_tokenproxy','Can delete token');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (68,17,'view_tokenproxy','Can view token');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (69,18,'add_comingtreatment','Can add coming treatment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (70,18,'change_comingtreatment','Can change coming treatment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (71,18,'delete_comingtreatment','Can delete coming treatment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (72,18,'view_comingtreatment','Can view coming treatment');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (73,19,'add_clinicalexamination','Can add clinical examination');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (74,19,'change_clinicalexamination','Can change clinical examination');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (75,19,'delete_clinicalexamination','Can delete clinical examination');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (76,19,'view_clinicalexamination','Can view clinical examination');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (77,20,'add_medicalexamination','Can add medical examination');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (78,20,'change_medicalexamination','Can change medical examination');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (79,20,'delete_medicalexamination','Can delete medical examination');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (80,20,'view_medicalexamination','Can view medical examination');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (2,'auth','permission');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (3,'auth','group');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (4,'contenttypes','contenttype');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (5,'sessions','session');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (6,'core','user');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (7,'core','address');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (8,'core','doctor');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (9,'core','timetable');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (10,'core','schedule');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (11,'core','patient');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (12,'core','appointment');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (13,'core','currentpatients');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (14,'core','attachment');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (15,'core','treatment');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (16,'authtoken','token');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (17,'authtoken','tokenproxy');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (18,'core','comingtreatment');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (19,'core','clinicalexamination');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (20,'core','medicalexamination');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (1,'contenttypes','0001_initial','2020-10-11 16:49:14.905325');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (2,'contenttypes','0002_remove_content_type_name','2020-10-11 16:49:14.945169');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (3,'auth','0001_initial','2020-10-11 16:49:14.970495');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (4,'auth','0002_alter_permission_name_max_length','2020-10-11 16:49:15.006738');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (5,'auth','0003_alter_user_email_max_length','2020-10-11 16:49:15.053727');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (6,'auth','0004_alter_user_username_opts','2020-10-11 16:49:15.090538');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (7,'auth','0005_alter_user_last_login_null','2020-10-11 16:49:15.107397');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (8,'auth','0006_require_contenttypes_0002','2020-10-11 16:49:15.133881');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (9,'auth','0007_alter_validators_add_error_messages','2020-10-11 16:49:15.160804');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (10,'auth','0008_alter_user_username_max_length','2020-10-11 16:49:15.205518');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (11,'auth','0009_alter_user_last_name_max_length','2020-10-11 16:49:15.254449');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (12,'auth','0010_alter_group_name_max_length','2020-10-11 16:49:15.286969');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (13,'auth','0011_update_proxy_permissions','2020-10-11 16:49:15.329157');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (14,'auth','0012_alter_user_first_name_max_length','2020-10-11 16:49:15.372011');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (15,'core','0001_initial','2020-10-11 16:49:15.412696');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (16,'admin','0001_initial','2020-10-11 16:49:15.453907');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (17,'admin','0002_logentry_remove_auto_add','2020-10-11 16:49:15.486004');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (18,'admin','0003_logentry_add_action_flag_choices','2020-10-11 16:49:15.527115');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (19,'core','0002_address_appointment_doctor_patient_schedule_timetable','2020-10-11 16:49:15.597717');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (20,'core','0003_auto_20201011_1140','2020-10-11 16:49:15.661798');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (21,'core','0004_auto_20201011_1255','2020-10-11 16:49:15.711496');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (22,'core','0005_auto_20201011_1512','2020-10-11 16:49:15.762823');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (23,'core','0006_auto_20201011_1519','2020-10-11 16:49:15.914582');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (24,'sessions','0001_initial','2020-10-11 16:49:15.940983');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (25,'core','0007_auto_20201011_2052','2020-10-11 17:52:20.589113');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (26,'core','0008_attachment_treatment','2020-10-12 14:13:06.874571');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (27,'core','0009_auto_20201012_1029','2020-10-12 14:13:06.933103');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (28,'core','0010_auto_20201014_1105','2020-10-14 08:05:50.842123');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (29,'core','0011_attachment_user','2020-10-14 20:27:33.495136');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (30,'core','0012_remove_attachment_user','2020-10-14 20:34:58.283009');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (31,'core','0013_treatment_title','2020-10-15 19:06:01.707809');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (32,'core','0014_remove_treatment_user','2020-10-16 04:00:18.085395');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (33,'core','0015_treatment_user','2020-10-16 04:59:37.915124');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (34,'core','0016_attachment_filename','2020-10-16 11:02:48.187023');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (35,'core','0017_auto_20201016_1406','2020-10-16 11:06:42.336170');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (36,'core','0018_auto_20201017_0912','2020-10-17 06:12:10.909411');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (37,'authtoken','0001_initial','2020-10-19 06:56:19.517980');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (38,'authtoken','0002_auto_20160226_1747','2020-10-19 06:56:19.578986');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (39,'authtoken','0003_tokenproxy','2020-10-19 06:56:19.585985');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (40,'core','0019_auto_20201023_2237','2020-10-23 19:37:34.136071');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (41,'core','0020_auto_20201024_0921','2020-10-24 06:21:07.746590');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (42,'core','0021_auto_20201027_1423','2020-10-27 11:24:07.245124');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (43,'core','0022_auto_20201027_1436','2020-10-27 11:36:41.718140');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (44,'core','0023_auto_20201027_1438','2020-10-27 11:38:37.853118');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (45,'core','0002_auto_20201029_2301','2020-10-29 20:04:10.158972');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (46,'core','0003_remove_attachment_patient','2020-10-30 05:01:27.580646');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (47,'core','0004_attachment_patient','2020-10-30 05:02:28.413054');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (48,'core','0005_auto_20201030_0805','2020-10-30 05:10:48.616266');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (49,'core','0006_attachment_description','2020-10-30 05:22:54.147319');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (50,'core','0007_remove_attachment_description','2020-10-30 05:27:13.885028');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (51,'core','0008_attachment_file_type','2020-11-01 18:09:42.254432');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (52,'core','0009_auto_20201103_1134','2020-11-03 08:34:54.578407');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (53,'core','0010_auto_20201103_1150','2020-11-03 08:50:38.263828');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (54,'core','0011_auto_20201103_1152','2020-11-05 06:16:12.144520');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (55,'core','0012_attachment_page_count','2020-11-06 10:23:31.524242');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (56,'core','0013_patient_image','2020-11-10 17:45:40.658583');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (57,'core','0014_auto_20201112_2358','2020-11-12 23:58:56.521476');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (58,'core','0015_auto_20201113_2153','2020-11-13 21:54:06.770139');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (59,'core','0016_auto_20201116_1926','2020-11-16 19:32:56.168476');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (60,'core','0017_auto_20201116_1943','2020-11-16 19:43:49.681251');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (61,'core','0018_auto_20201118_1429','2020-11-18 14:29:16.612526');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (62,'core','0019_medicalexamination','2020-11-18 15:10:39.100231');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (63,'core','0020_medicalexamination_patient','2020-11-18 15:14:33.145874');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (64,'core','0018_auto_20201118_1517','2020-11-18 15:17:39.138842');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (65,'core','0020_auto_20201118_1520','2020-11-18 15:20:51.029940');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (66,'core','0021_auto_20201118_1521','2020-11-18 15:21:13.960774');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (67,'core','0022_auto_20201118_1522','2020-11-18 15:22:19.316594');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (68,'core','0023_auto_20201121_1502','2020-11-21 15:02:20.990149');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (69,'core','0024_auto_20201127_1500','2020-11-27 15:01:27.361743');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (70,'core','0025_auto_20201127_1508','2020-11-27 15:08:20.035026');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (71,'core','0026_auto_20201127_1518','2020-11-27 15:18:20.043252');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (72,'core','0024_auto_20201128_1510','2020-11-28 15:10:25.812058');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (73,'core','0025_comingtreatment_date_to','2020-12-04 14:16:21.099055');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (74,'core','0026_comingtreatment_title','2020-12-04 15:23:04.383685');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (75,'core','0027_auto_20201204_1542','2020-12-04 15:42:42.619303');
CREATE INDEX IF NOT EXISTS "core_comingtreatment_user_id_2bb0580c" ON "core_comingtreatment" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "core_comingtreatment_patient_id_5fdbd80b" ON "core_comingtreatment" (
	"patient_id"
);
CREATE INDEX IF NOT EXISTS "core_patient_user_id_96d54e7e" ON "core_patient" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "core_patient_doctor_id_e43049f1" ON "core_patient" (
	"doctor_id"
);
CREATE INDEX IF NOT EXISTS "core_patient_address_id_4d8aa7a4" ON "core_patient" (
	"address_id"
);
CREATE INDEX IF NOT EXISTS "core_treatment_user_id_05b457a9" ON "core_treatment" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "core_treatment_patient_id_1e573eab" ON "core_treatment" (
	"patient_id"
);
CREATE INDEX IF NOT EXISTS "core_treatment_appointment_id_2cbf366d" ON "core_treatment" (
	"appointment_id"
);
CREATE INDEX IF NOT EXISTS "core_attachment_patient_id_448422c6" ON "core_attachment" (
	"patient_id"
);
CREATE INDEX IF NOT EXISTS "core_attachment_user_id_e8f6caa0" ON "core_attachment" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "core_treatment_files_attachment_id_5c58e922" ON "core_treatment_files" (
	"attachment_id"
);
CREATE INDEX IF NOT EXISTS "core_treatment_files_treatment_id_e7dd914c" ON "core_treatment_files" (
	"treatment_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "core_treatment_files_treatment_id_attachment_id_16be6d52_uniq" ON "core_treatment_files" (
	"treatment_id",
	"attachment_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "core_timetable_user_id_2d3d8004" ON "core_timetable" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "core_schedule_user_id_bb884e2a" ON "core_schedule" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "core_schedule_timetable_id_8f041cb7" ON "core_schedule" (
	"timetable_id"
);
CREATE INDEX IF NOT EXISTS "core_schedule_doctor_id_22c0f77c" ON "core_schedule" (
	"doctor_id"
);
CREATE INDEX IF NOT EXISTS "core_doctor_user_id_e7476eac" ON "core_doctor" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "core_doctor_address_id_e4fdec84" ON "core_doctor" (
	"address_id"
);
CREATE INDEX IF NOT EXISTS "core_currentpatients_user_id_19379c01" ON "core_currentpatients" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "core_currentpatients_patient_id_e86a771c" ON "core_currentpatients" (
	"patient_id"
);
CREATE INDEX IF NOT EXISTS "core_currentpatients_appointment_id_dd86aa15" ON "core_currentpatients" (
	"appointment_id"
);
CREATE INDEX IF NOT EXISTS "core_appointment_user_id_9c7816e1" ON "core_appointment" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "core_appointment_patient_id_960b1d60" ON "core_appointment" (
	"patient_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "core_user_user_permissions_permission_id_35ccf601" ON "core_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "core_user_user_permissions_user_id_085123d3" ON "core_user_user_permissions" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "core_user_user_permissions_user_id_permission_id_73ea0daa_uniq" ON "core_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "core_user_groups_group_id_fe8c697f" ON "core_user_groups" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "core_user_groups_user_id_70b4d9b8" ON "core_user_groups" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "core_user_groups_user_id_group_id_c82fcad1_uniq" ON "core_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
COMMIT;
