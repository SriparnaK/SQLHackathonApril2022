--55 -Get all assignment for each user

-- 56 -Find the staff who graded the assignments for a single batch.

SELECT 
	b.batch_id,
	u.user_id,
	u.user_first_name,	
	u.user_last_name	
FROM tbl_lms_batch b
	INNER JOIN tbl_lms_assignments AS a ON b.batch_id = a.a_batch_id
	INNER JOIN tbl_lms_submissions AS s ON s.sub_a_id = a.a_id
	INNER JOIN tbl_lms_user AS u ON u.user_id = s.graded_by
WHERE b.batch_id='2'
GROUP BY b.batch_id, u.user_id 

--57 Delete Assignment

DELETE FROM tbl_lms_assignments WHERE a_id='1';

--58 -Create new Submission for an new assignment



-- 59 - Get Submissions for an existing assignment
SELECT
	a.a_id AS Assignment_Id,
	a.a_name AS Assignment_Name,
	a.a_description AS Assignment_Description,
	s.sub_id AS Submission_Id,
	s.sub_student_id AS Submitted_By,
	s.sub_comments AS Submission_Comments,
	s.sub_path_attach1 AS Attachment1,
	s.sub_path_attach2 AS Attachment2,
	s.sub_path_attach3 AS Attachment3,
	s.sub_path_attach4 AS Attachment4,
	s.sub_path_attach5 AS Attachment5,
	s.sub_datetime AS Submitted_On,
	s.graded_by AS Submission_Graded_By,
	s.graded_datetime AS Submission_Graded_On,
	s.grade AS Submission_Grade	
FROM tbl_lms_submissions AS s
	INNER JOIN tbl_lms_assignments AS a ON s.sub_a_id = a.a_id
WHERE a.a_id = 1


-- 60 -Get all Submissions by all Users
SELECT 
	u.user_id,
	u.user_first_name,
	u.user_last_name,
	s.sub_description,
	s.sub_comments
FROM tbl_lms_user AS u
	INNER JOIN tbl_lms_submissions AS s ON s.sub_student_id = u.user_id

-- 61 -Get all Submissions by Batches

SELECT
	b.batch_id AS batch_id,
	b.batch_name AS batch_name,
	b.batch_description AS batch_description,
	a.a_id AS Assignment_Id,
	a.a_name AS Assignment_Name,
	a.a_description AS Assignment_Description,	
	s.sub_id AS Submission_Id,
	u.user_first_name AS submitted_by_first_name,
	u.user_last_name AS submitted_by_last_name,	
	s.sub_comments AS Submission_Comments,
	s.graded_by AS Submission_Graded_By,
	s.grade AS Submission_Grade,	
	s.sub_path_attach1 AS Attachment1,
	s.sub_path_attach2 AS Attachment2,
	s.sub_path_attach3 AS Attachment3,
	s.sub_path_attach4 AS Attachment4,
	s.sub_path_attach5 AS Attachment5,
	s.sub_datetime AS Submitted_On,	
	s.graded_datetime AS Submission_Graded_On	
FROM tbl_lms_batch AS b	
	LEFT JOIN tbl_lms_assignments AS a ON b.batch_id = a.a_batch_id
	LEFT JOIN tbl_lms_submissions AS s ON s.sub_a_id = a.a_id
	LEFT JOIN tbl_lms_user AS u ON u.user_id = s.sub_student_id
WHERE b.batch_status ='Active'

-- 62 -Get all Submissions by Batches and find highest number of submissions per batch
SELECT b.batch_id,a.a_id, COUNT(s.sub_id) Allsubmissions 
	FROM tbl_lms_batch AS b
	LEFT JOIN tbl_lms_assignments AS a ON b.batch_id = a.a_batch_id
	LEFT JOIN tbl_lms_submissions AS s ON s.sub_a_id = a.a_id
	WHERE b.batch_status ='Active'
	GROUP BY b.batch_id, a.a_id
	having COUNT(s.sub_id) =	
(SELECT MAX(submissions)
	FROM 
(SELECT b.batch_id,a.a_id, COUNT(s.sub_id) submissions 
	FROM tbl_lms_batch AS b
	LEFT JOIN tbl_lms_assignments AS a ON b.batch_id = a.a_batch_id
	LEFT JOIN tbl_lms_submissions AS s ON s.sub_a_id = a.a_id
	WHERE b.batch_status ='Active'
	GROUP BY b.batch_id, a.a_id) AS max_sub)

-- 63 -"Update Submissions 1) Assign new grades for a particular assignment of a particular batch"

	
-- 64 -Delete Submission

DELETE 
	FROM tbl_lms_submissions 
	WHERE sub_id='2';

-- 65 -Update or Assign a new grade for a particular submission
UPDATE tbl_lms_submissions 
	SET grade = 255 
	Where sub_id='1';

-- 66 -Get grades of students in a batch
SELECT
	b.batch_id AS batch_id,
	b.batch_name AS batch_name,
	b.batch_description AS batch_description,
	--a.a_id AS Assignment_Id,
	--a.a_name AS Assignment_Name,
	--s.sub_id AS Submission_Id,
	u.user_first_name AS submitted_by_first_name,
	u.user_last_name AS submitted_by_last_name,	
	s.graded_by AS Graded_By,
	s.grade AS Grades		
FROM tbl_lms_batch AS b	
	LEFT JOIN tbl_lms_assignments AS a ON b.batch_id = a.a_batch_id
	INNER JOIN tbl_lms_submissions AS s ON s.sub_a_id = a.a_id
	LEFT JOIN tbl_lms_user AS u ON u.user_id = s.sub_student_id
WHERE batch_id='2';

-- 67 -Get all users for a batch and then get the user with the highest grade for a particular assignment

--Manage Skills

--68 Create a new skill

INSERT INTO tbl_lms_skill_master(
	skill_id, skill_name, creation_time, last_mod_time)
	VALUES ('7','Gherkins','2022-10-04','2021-10-04');

-- 69 -Get all Skills by Name	

-- 70 -Get a particular skill and update experience

Update tbl_lms_skill_master 
	SET skill_name='Gherkin'
	WHERE skill_id= '7';
	
-- 71 -Get skills by all users and display the user with high number of skills

SELECT u.user_id,u.user_first_name,u.user_last_name,count(um.skill_id) AS skill_count
FROM tbl_lms_user AS u
INNER JOIN tbl_lms_userskill_map AS um ON um.user_id=u.user_id
GROUP BY u.user_id 
having count(um.skill_id) =
(SELECT MAX(skill_count)
FROM 
(
SELECT u.user_id,u.user_first_name,u.user_last_name,count(um.skill_id) AS skill_count
FROM tbl_lms_user AS u
INNER JOIN tbl_lms_userskill_map AS um ON um.user_id=u.user_id
GROUP BY u.user_id 
ORDER BY u.user_id) AS user_skill_count)
	
	
-- 72 -Delete Skills
DELETE 
FROM tbl_lms_skill_master 
WHERE skill_id='7';
