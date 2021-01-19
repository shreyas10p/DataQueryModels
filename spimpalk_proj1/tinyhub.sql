CREATE DATABASE tinyhub;
USE tinyhub;

--
-- Host: localhost    Database: tinyhub
-- ------------------------------------------------------
-- Server version	8.0.13

--
-- Table structure for table `user`
--


CREATE TABLE `user` (
  `email` varchar(320) NOT NULL,
  `displayname` varchar(400) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `accounttype` int(11) NOT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `index2` (`displayname`)
);

--
-- Table structure for table `departments`
--


CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
); 

--
-- Table structure for table `program`
--


CREATE TABLE `program` (
  `program_id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`program_id`),
  KEY `fk_program_1_idx` (`department_id`),
  CONSTRAINT `fk_program_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `students`
--


CREATE TABLE `students` (
  `student_email` varchar(320) NOT NULL,
  PRIMARY KEY (`student_email`),
  CONSTRAINT `fk_students_1` FOREIGN KEY (`student_email`) REFERENCES `user` (`email`)
); 
--
-- Table structure for table `professor`
--


CREATE TABLE `professor` (
  `professor_email` varchar(320) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`professor_email`),
  KEY `fk_professor_1_idx` (`department_id`),
  CONSTRAINT `fk_professor_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_professor_2` FOREIGN KEY (`professor_email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
);
--
-- Table structure for table `staff`
--


CREATE TABLE `staff` (
  `staff_email` varchar(320) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`staff_email`),
  KEY `fk_staff_2_idx` (`department_id`),
  CONSTRAINT `fk_staff_1` FOREIGN KEY (`staff_email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE
); 
--
-- Table structure for table `student_major`
--


CREATE TABLE `student_major` (
  `student_email` varchar(320) NOT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`student_email`,`department_id`),
  KEY `fk_student_major_1_idx` (`department_id`),
  CONSTRAINT `fk_student_major_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_major_2` FOREIGN KEY (`student_email`) REFERENCES `students` (`student_email`) ON DELETE CASCADE ON UPDATE CASCADE
); 
--
-- Table structure for table `pursued_programs`
--


CREATE TABLE `pursued_programs` (
  `student_email` varchar(320) NOT NULL,
  `program_id` int(11) NOT NULL,
  PRIMARY KEY (`student_email`,`program_id`),
  KEY `fk_pursued_programs_2_idx` (`program_id`),
  CONSTRAINT `fk_pursued_programs_1` FOREIGN KEY (`student_email`) REFERENCES `students` (`student_email`),
  CONSTRAINT `fk_pursued_programs_2` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE CASCADE ON UPDATE CASCADE
); 
--
-- Table structure for table `courses`
--


CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `fk_courses_1_idx` (`department_id`),
  CONSTRAINT `fk_courses_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `semester`
--


CREATE TABLE `semester` (
  `year` int(11) NOT NULL,
  `season` varchar(45) NOT NULL,
  PRIMARY KEY (`year`,`season`)
); 

--
-- Table structure for table `opened_course_id`
--


CREATE TABLE `opened_course_id` (
  `opened_course_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `year` int(11) DEFAULT NULL,
  `season` varchar(45) DEFAULT NULL,
  `capacity` int(20) DEFAULT NULL,
  `instructor` varchar(320) DEFAULT NULL,
  PRIMARY KEY (`opened_course_id`),
  KEY `fk_opened_course_id_1_idx` (`course_id`),
  KEY `fk_opened_course_id_2_idx` (`year`,`season`),
  KEY `fk_opened_course_id_4_idx` (`instructor`),
  CONSTRAINT `fk_opened_course_id_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_opened_course_id_2` FOREIGN KEY (`year`, `season`) REFERENCES `semester` (`year`, `season`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_opened_course_id_4` FOREIGN KEY (`instructor`) REFERENCES `professor` (`professor_email`) ON DELETE CASCADE ON UPDATE CASCADE
); 

--
-- Table structure for table `teaching_assistants`
--



CREATE TABLE `teaching_assistants` (
  `student` varchar(320) NOT NULL,
  `opened_course_id` int(11) NOT NULL,
  PRIMARY KEY (`student`),
  KEY `fk_teaching_assistants_2_idx` (`opened_course_id`),
  CONSTRAINT `fk_teaching_assistants_1` FOREIGN KEY (`student`) REFERENCES `students` (`student_email`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_teaching_assistants_2` FOREIGN KEY (`opened_course_id`) REFERENCES `opened_course_id` (`opened_course_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `sem_registration`
--


CREATE TABLE `sem_registration` (
  `student_id` varchar(320) NOT NULL,
  `year` int(11) NOT NULL,
  `season` varchar(45) NOT NULL,
  PRIMARY KEY (`student_id`,`year`,`season`),
  KEY `fk_sem_registration_2_idx` (`year`,`season`),
  CONSTRAINT `fk_sem_registration_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_email`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sem_registration_2` FOREIGN KEY (`year`, `season`) REFERENCES `semester` (`year`, `season`) ON DELETE CASCADE ON UPDATE CASCADE
); 

--
-- Table structure for table `prerequisite_course`
--


CREATE TABLE `prerequisite_course` (
  `course_id` int(11) NOT NULL,
  `prerequisite_courseid` int(11) NOT NULL,
  PRIMARY KEY (`course_id`,`prerequisite_courseid`),
  KEY `fk_prerequisite_course_1_idx` (`course_id`),
  KEY `fk_prerequisite_course_2_idx` (`prerequisite_courseid`),
  CONSTRAINT `fk_prerequisite_course_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_prerequisite_course_2` FOREIGN KEY (`prerequisite_courseid`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `enrolled`
--


CREATE TABLE `enrolled` (
  `registered_student` varchar(320) NOT NULL,
  `opened_course` int(11) NOT NULL,
  `year` int(11) DEFAULT NULL,
  `season` varchar(45) DEFAULT NULL,
  `grade` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`registered_student`,`opened_course`),
  KEY `fk_enrolled_2_idx` (`opened_course`),
  KEY `fk_enrolled_1_idx` (`registered_student`,`year`,`season`),
  CONSTRAINT `fk_enrolled_1` FOREIGN KEY (`registered_student`, `year`, `season`) REFERENCES `sem_registration` (`student_id`, `year`, `season`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_enrolled_2` FOREIGN KEY (`opened_course`) REFERENCES `opened_course_id` (`opened_course_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `exams`
--


CREATE TABLE `exams` (
  `exam_id` int(11) NOT NULL AUTO_INCREMENT,
  `opened_course` int(11) DEFAULT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `fk_exams_1_idx` (`opened_course`),
  CONSTRAINT `fk_exams_1` FOREIGN KEY (`opened_course`) REFERENCES `opened_course_id` (`opened_course_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `exam_result`
--


CREATE TABLE `exam_result` (
  `exam_id` int(11) NOT NULL,
  `enrolled_student` varchar(320) NOT NULL,
  `grade` varchar(10) NOT NULL,
  PRIMARY KEY (`exam_id`,`enrolled_student`),
  KEY `fk_exam_result_2_idx` (`enrolled_student`),
  CONSTRAINT `fk_exam_result_1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`exam_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_exam_result_2` FOREIGN KEY (`enrolled_student`) REFERENCES `enrolled` (`registered_student`) ON DELETE CASCADE ON UPDATE CASCADE
);
--
-- Table structure for table `problems`
--


CREATE TABLE `problems` (
  `problem_id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` int(11) NOT NULL,
  PRIMARY KEY (`problem_id`),
  KEY `fk_problems_1_idx` (`exam_id`),
  CONSTRAINT `fk_problems_1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`exam_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `problem_score`
--


CREATE TABLE `problem_score` (
  `problem_id` int(11) NOT NULL,
  `enrolled_student` varchar(45) NOT NULL,
  `score` int(10) DEFAULT NULL,
  PRIMARY KEY (`problem_id`,`enrolled_student`),
  KEY `fk_problem_score_2_idx` (`enrolled_student`),
  CONSTRAINT `fk_problem_score_1` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`problem_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_problem_score_2` FOREIGN KEY (`enrolled_student`) REFERENCES `enrolled` (`registered_student`) ON DELETE CASCADE ON UPDATE CASCADE
);
--
-- Table structure for table `instructor_feedback`
--


CREATE TABLE `instructor_feedback` (
  `opened_course` int(11) NOT NULL,
  `enrolled_student` varchar(45) NOT NULL,
  `feedback` longtext,
  PRIMARY KEY (`opened_course`,`enrolled_student`),
  KEY `fk_instructor_feedback_2_idx` (`enrolled_student`),
  CONSTRAINT `fk_instructor_feedback_1` FOREIGN KEY (`opened_course`) REFERENCES `opened_course_id` (`opened_course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_instructor_feedback_2` FOREIGN KEY (`enrolled_student`) REFERENCES `enrolled` (`registered_student`) ON DELETE CASCADE ON UPDATE CASCADE
); 

--
-- Table structure for table `site`
--


CREATE TABLE `site` (
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`site_id`)
); 

--
-- Table structure for table `author`
--


CREATE TABLE `author` (
  `author_id` int(11) NOT NULL,
  `author_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`author_id`)
);

--
-- Table structure for table `book`
--



CREATE TABLE `book` (
  `ISBN` int(11) NOT NULL,
  `title` varchar(45) NOT NULL,
  `num_pages` int(11) NOT NULL,
  `publication_date` date NOT NULL,
  PRIMARY KEY (`ISBN`)
); 

--
-- Table structure for table `book_author`
--


CREATE TABLE `book_author` (
  `book_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`book_id`,`author_id`),
  KEY `fk_book_author_2_idx` (`author_id`),
  CONSTRAINT `fk_book_author_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_book_author_2` FOREIGN KEY (`author_id`) REFERENCES `author` (`author_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `copy`
--


CREATE TABLE `copy` (
  `copy_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `date_of_purchase` date DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`copy_id`),
  KEY `fk_copy_1_idx` (`book_id`),
  KEY `fk_copy_2_idx` (`site_id`),
  CONSTRAINT `fk_copy_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`isbn`),
  CONSTRAINT `fk_copy_2` FOREIGN KEY (`site_id`) REFERENCES `site` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE
); 

--
-- Table structure for table `borrowed_books`
--


CREATE TABLE `borrowed_books` (
  `user_id` varchar(320) NOT NULL,
  `copy_id` int(11) NOT NULL,
  `returnDate` date DEFAULT NULL,
  `isreturned` tinyint(4) NOT NULL,
  `isextended` tinyint(4) NOT NULL,
  PRIMARY KEY (`user_id`,`copy_id`),
  KEY `fk_borrowed_books_2_idx` (`copy_id`),
  CONSTRAINT `fk_borrowed_books_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_borrowed_books_2` FOREIGN KEY (`copy_id`) REFERENCES `copy` (`copy_id`) ON DELETE CASCADE ON UPDATE CASCADE
); 

