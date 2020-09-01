-- Creating full text indexes
ALTER TABLE JobCategories ADD FULLTEXT(`name`);
ALTER TABLE JobTypes ADD FULLTEXT(`name`);
ALTER TABLE Jobs ADD FULLTEXT(`name`,description,detail,business_skill,knowledge,location,activity,salary_statistic_group,salary_range_remarks,restriction,remarks);
ALTER TABLE Personalities ADD FULLTEXT(`name`);
ALTER TABLE PracticalSkills ADD FULLTEXT(`name`);
ALTER TABLE BasicAbilities ADD FULLTEXT(`name`);
ALTER TABLE affiliates ADD FULLTEXT(`name`);
-- Changes to the given SQL Query
SELECT Jobs.id AS `Jobs__id`,
Jobs.name AS `Jobs__name`,
Jobs.media_id AS `Jobs__media_id`,
Jobs.job_category_id AS `Jobs__job_category_id`,
Jobs.job_type_id AS `Jobs__job_type_id`,
Jobs.description AS `Jobs__description`,
Jobs.detail AS `Jobs__detail`,
Jobs.business_skill AS `Jobs__business_skill`,
Jobs.knowledge AS `Jobs__knowledge`,
Jobs.location AS `Jobs__location`,
Jobs.activity AS `Jobs__activity`,
Jobs.academic_degree_doctor AS `Jobs__academic_degree_doctor`,
Jobs.academic_degree_master AS `Jobs__academic_degree_master`,
Jobs.academic_degree_professional AS `Jobs__academic_degree_professional`,
Jobs.academic_degree_bachelor AS `Jobs__academic_degree_bachelor`,
Jobs.salary_statistic_group AS `Jobs__salary_statistic_group`,
Jobs.salary_range_first_year AS `Jobs__salary_range_first_year`,
Jobs.salary_range_average AS `Jobs__salary_range_average`,
Jobs.salary_range_remarks AS `Jobs__salary_range_remarks`,
Jobs.restriction AS `Jobs__restriction`,
Jobs.estimated_total_workers AS `Jobs__estimated_total_workers`,
Jobs.remarks AS `Jobs__remarks`,
Jobs.url AS `Jobs__url`,
Jobs.seo_description AS `Jobs__seo_description`,
Jobs.seo_keywords AS `Jobs__seo_keywords`,
Jobs.sort_order AS `Jobs__sort_order`,
Jobs.publish_status AS `Jobs__publish_status`,
Jobs.version AS `Jobs__version`,
Jobs.created_by AS `Jobs__created_by`,
Jobs.created AS `Jobs__created`,
Jobs.modified AS `Jobs__modified`,
Jobs.deleted AS `Jobs__deleted`,
JobCategories.id AS `JobCategories__id`,
JobCategories.name AS `JobCategories__name`,
JobCategories.sort_order AS `JobCategories__sort_order`,
JobCategories.created_by AS `JobCategories__created_by`,
JobCategories.created AS `JobCategories__created`,
JobCategories.modified AS `JobCategories__modified`,
JobCategories.deleted AS `JobCategories__deleted`,
JobTypes.id AS `JobTypes__id`,
JobTypes.name AS `JobTypes__name`,
JobTypes.job_category_id AS `JobTypes__job_category_id`,
JobTypes.sort_order AS `JobTypes__sort_order`,
JobTypes.created_by AS `JobTypes__created_by`,
JobTypes.created AS `JobTypes__created`,
JobTypes.modified AS `JobTypes__modified`,
JobTypes.deleted AS `JobTypes__deleted`
FROM jobs Jobs
LEFT JOIN jobs_personalities JobsPersonalities
ON Jobs.id = (JobsPersonalities.job_id)
LEFT JOIN personalities Personalities
ON (Personalities.id = (JobsPersonalities.personality_id)
AND (Personalities.deleted) IS NULL)
LEFT JOIN jobs_practical_skills JobsPracticalSkills
ON Jobs.id = (JobsPracticalSkills.job_id)
LEFT JOIN practical_skills PracticalSkills
ON (PracticalSkills.id = (JobsPracticalSkills.practical_skill_id)
AND (PracticalSkills.deleted) IS NULL)
LEFT JOIN jobs_basic_abilities JobsBasicAbilities
ON Jobs.id = (JobsBasicAbilities.job_id)
LEFT JOIN basic_abilities BasicAbilities
ON (BasicAbilities.id = (JobsBasicAbilities.basic_ability_id)
AND (BasicAbilities.deleted) IS NULL)
LEFT JOIN jobs_tools JobsTools
ON Jobs.id = (JobsTools.job_id)
LEFT JOIN affiliates Tools
ON (Tools.type = 1
AND Tools.id = (JobsTools.affiliate_id)
AND (Tools.deleted) IS NULL)
LEFT JOIN jobs_career_paths JobsCareerPaths
ON Jobs.id = (JobsCareerPaths.job_id)
LEFT JOIN affiliates CareerPaths
ON (CareerPaths.type = 3
AND CareerPaths.id = (JobsCareerPaths.affiliate_id)
AND (CareerPaths.deleted) IS NULL)
LEFT JOIN jobs_rec_qualifications JobsRecQualifications
ON Jobs.id = (JobsRecQualifications.job_id)
LEFT JOIN affiliates RecQualifications
ON (RecQualifications.type = 2
AND RecQualifications.id = (JobsRecQualifications.affiliate_id)
AND (RecQualifications.deleted) IS NULL)
LEFT JOIN jobs_req_qualifications JobsReqQualifications
ON Jobs.id = (JobsReqQualifications.job_id)
LEFT JOIN affiliates ReqQualifications
ON (ReqQualifications.type = 2
AND ReqQualifications.id = (JobsReqQualifications.affiliate_id)
AND (ReqQualifications.deleted) IS NULL)
INNER JOIN job_categories JobCategories
ON (JobCategories.id = (Jobs.job_category_id)
AND (JobCategories.deleted) IS NULL)
INNER JOIN job_types JobTypes
ON (JobTypes.id = (Jobs.job_type_id)
AND (JobTypes.deleted) IS NULL)
WHERE ((MATCH(JobCategories.name) AGAINST ('キャビンアテンダント')
MATCH(JobTypes.name) AGAINST ('キャビンアテンダント')
MATCH(Jobs.name,Jobs.description,Jobs.detail,Jobs.business_skill,Jobs.knowledge,Jobs.location,Jobs.activity,Jobs.salary_statistic_group,Jobs.salary_range_remarks,Jobs.restriction,Jobs.remarks) AGAINST ('キャビンアテンダント')
MATCH(Personalities.name) AGAINST ('キャビンアテンダント')
MATCH(PracticalSkills.name) AGAINST ('キャビンアテンダント')
MATCH(BasicAbilities.name) AGAINST ('キャビンアテンダント')
MATCH(Tools.name) AGAINST ('キャビンアテンダント')
MATCH(CareerPaths.name) AGAINST ('キャビンアテンダント')
MATCH(RecQualifications.name) AGAINST ('キャビンアテンダント')
MATCH(ReqQualifications.name) AGAINST ('キャビンアテンダント'))
AND publish_status = 1
AND (Jobs.deleted) IS NULL)
GROUP BY Jobs.id
ORDER BY Jobs.sort_order desc,
Jobs.id DESC LIMIT 50 OFFSET 0

ALTER TABLE Jobs ADD INDEX Jobs_idx (id,sort_order,deleted,job_category_id,job_type_id,publish_status);
ALTER TABLE Personalities ADD INDEX Personalities_idx (id,deleted);
ALTER TABLE jobs_personalities ADD INDEX jobs_personalities_idx (job_id,personality_id);
ALTER TABLE jobs_practical_skills ADD INDEX jobs_practical_skills_idx (job_id,practical_skill_id);
ALTER TABLE practical_skills ADD INDEX practical_skills_idx (id,deleted);
ALTER TABLE jobs_basic_abilities ADD INDEX jobs_basic_abilities_idx (job_id,basic_ability_id);
ALTER TABLE basic_abilities ADD INDEX basic_abilities_idx (id,deleted);
ALTER TABLE affiliates ADD INDEX affiliates_idx (id,deleted,`type`);
ALTER TABLE jobs_tools ADD INDEX jobs_tools_idx (job_id,affiliate_id);
ALTER TABLE jobs_career_paths ADD INDEX jobs_career_paths_idx (job_id,affiliate_id);
ALTER TABLE jobs_rec_qualifications ADD INDEX jobs_rec_qualifications_idx (job_id,affiliate_id);
ALTER TABLE jobs_req_qualifications ADD INDEX jobs_req_qualifications_idx (job_id,affiliate_id);
ALTER TABLE job_categories ADD INDEX job_categories_idx (id,deleted);
ALTER TABLE job_types ADD INDEX job_types_idx (id,deleted);

