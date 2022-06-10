# Level.create!([
#   {name: "A1", title: "Junior"},
#   {name: "A2", title: "Middle"},
#   {name: "A3", title: "Senior"},
#   {name: "A4", title: "Lead"}
# ])

# SkillCategory.create!([
#                         {name: "Engineering Management", parent_category_id: nil},
#                         {name: "Process planning", parent_category_id: 4},
#                         {name: "Estimation", parent_category_id: 4}
#                       ])
# Skill.create!([
#                 {name: "Ruby Web Development", description: " Development of web applications using Ruby tech stack, including both \"classic\" web apps and modern cloud ecosystems and microservices.  Relies on Ruby language ecosystem", skill_category_id: 2},
#                 {name: "Competency Growth", description: "Competency Growth", skill_category_id: 1},
#                 {name: "Data Intelligence CC", description: "Data Intelligence CC", skill_category_id: 1},
#                 {name: "MySQL. SQL to programming langs", description: "MySQL. SQL to programming langs", skill_category_id: 2}
#               ])
#
# SkillLevel.create!([
#                      {skill_id: 1, level_id: 9, notice: "qwer qwer"},
#                      {skill_id: 1, level_id: 10, notice: "I use the skill hands-on, but often need to review documentation/talk to others"},
#                      {skill_id: 1, level_id: 11, notice: ""},
#                      {skill_id: 1, level_id: 12, notice: ""}
#                    ])
# LearningMaterial.create!([
#   {material_type: nil, name: "@skill_level", link: "https://puzzle-english.com/words?new", learnable_id: 1, learnable_type: "SkillLevel"},
#   {material_type: "Book", name: "@skill_level", link: "@skill_level", learnable_id: 1, learnable_type: "SkillLevel"},
#   {material_type: "Article", name: "What", link: "What", learnable_id: 1, learnable_type: "SkillLevel"}
# ])
# JobFunction.create!([
#   {title: "Software Engineers"}
# ])
# MaterialContainer.create!([
#   {job_function_id: 1, level_id: 1}
# ])

["Engineering Management 1Process planning >Estimation >Requirements > ",
 "Design 1OOD >DB design >Algorithms > ",
 "Core 1Ruby Language >Security >Tools and Gems >Refactoring >Networking > ",
 "Web Back-End 1Ruby On Rails > ",
 "Web Front-End 1Web UI, JavaScript, HTML, CSS > Web UI, Libraries and Frameworks >",
 "DB 1SQL >DB Access >MySQL >NoSQL > ",
 "Web Back-End 1Cloud-based Deployment Services >Web and Application Servers > ",
 "Verification 1Code quality >Automation Testing >RSpec and Testing Libraries > ",
 "Configuration Management 1Managing versions >Continuous Integration >Product builds and Continuous Integration >Managing versions >"]

# z = a.split('>')
# z.last.gsub("\nsource", "")
# def create_items(string, skill_level_id)
#   skill_level = SkillLevel.find(skill_level_id)
#   items_array = string.gsub("\n", "").gsub(";", "").split("•").reject(&:blank?).map { |e| e.drop(1)}
#   items_array.each do |item|
#     skill_level.skill_level_items.create(name: item)
#   end
# end
# a.gsub("\nsource", " ").gsub("source", " ").gsub("\n", " ")
#
# def create_skills(string)
#   category_name = string.split("1").first
#   skills = string.split("1").last
#   skill_category = SkillCategory.find_or_create_by(name: category_name)
#   skills.split(">").reject(&:blank?).each do |skill_name|
#     skill = skill_category.skills.find_or_create_by(name: skill_name)
#     skill.level_ids = Level.where(name: ['A1', "A2", "A3"]).pluck(:id)
#   end
# end
# a.each do |string|
#   create_skills(string)
# end