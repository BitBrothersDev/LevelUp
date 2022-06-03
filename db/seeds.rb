Level.create!([
  {name: "A1", title: "Junior"},
  {name: "A2", title: "Middle"},
  {name: "A3", title: "Senior"},
  {name: "A4", title: "Lead"}
])


Skill.create!([
                {name: "Ruby Web Development", description: " Development of web applications using Ruby tech stack, including both \"classic\" web apps and modern cloud ecosystems and microservices.  Relies on Ruby language ecosystem", skill_category_id: nil},
                {name: "Competency Growth", description: "Competency Growth", skill_category_id: nil},
                {name: "Data Intelligence CC", description: "Data Intelligence CC", skill_category_id: nil},
                {name: "MySQL. SQL to programming langs", description: "MySQL. SQL to programming langs", skill_category_id: nil}
              ])

SkillLevel.create!([
                     {skill_id: 1, level_id: 1, notice: "qwer qwer"},
                     {skill_id: 1, level_id: 2, notice: "I use the skill hands-on, but often need to review documentation/talk to others"},
                     {skill_id: 1, level_id: 3, notice: ""},
                     {skill_id: 1, level_id: 4, notice: ""}
                   ])
LearningMaterial.create!([
  {material_type: "Article", name: "@skill_level", link: "@skill_level", learnable_id: 1, learnable_type: "SkillLevel"},
  {material_type: "Book", name: "@skill_level", link: "@skill_level", learnable_id: 1, learnable_type: "SkillLevel"},
  {material_type: "Article", name: "What", link: "What", learnable_id: 1, learnable_type: "SkillLevel"}
])
JobFunction.create!([
  {title: "Software Engineers"}
])
MaterialContainer.create!([
  {job_function_id: 1, level_id: 1}
])
