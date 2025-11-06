namespace :skills do
  desc "Normalize catalog data and add missing core skills"
  task sync: :environment do
    puts "Normalizing category names…"
    SkillCategory.find_each do |category|
      stripped = category.name&.strip
      next if stripped.blank?

      if stripped != category.name
        duplicate = SkillCategory.find_by(name: stripped)
        if duplicate
          category.skills.update_all(skill_category_id: duplicate.id)
          category.destroy!
        else
          category.update!(name: stripped)
        end
      end
    end

    missing_skills = [
      {
        category: "Configuration Management",
        name: "Infrastructure as Code",
        description: "Provision and manage infrastructure through declarative tools such as Terraform, CloudFormation, or Ansible to keep environments reproducible and reviewable.",
        crucial: true
      },
      {
        category: "Configuration Management",
        name: "Containerization & Orchestration",
        description: "Package services into containers (Docker) and operate them with orchestration platforms like Kubernetes or ECS, including image hygiene, rollout strategies, and runtime tuning.",
        crucial: true
      },
      {
        category: "Configuration Management",
        name: "Monitoring & Observability",
        description: "Instrument applications and infrastructure with metrics, logs, and traces (Prometheus, Grafana, OpenTelemetry) to detect regressions and inform capacity planning.",
        crucial: true
      },
      {
        category: "Core",
        name: "Concurrency & Parallelism",
        description: "Design Ruby workloads that leverage threads, fibers, and background workers safely, understanding the GIL, synchronization primitives, and async I/O patterns.",
        crucial: true
      },
      {
        category: "Core",
        name: "Performance Optimization & Profiling",
        description: "Profile Ruby and Rails applications (rack-mini-profiler, StackProf, memory_profiler) and apply code, query, and cache optimizations to hit latency and throughput targets.",
        crucial: true
      },
      {
        category: "Design",
        name: "System Design & Architecture",
        description: "Plan modular service boundaries, resilience patterns, and scaling strategies, including trade-offs between monoliths, microservices, and event-driven approaches.",
        crucial: true
      },
      {
        category: "Design",
        name: "Domain-Driven Design",
        description: "Model complex domains with bounded contexts, aggregates, and ubiquitous language to keep Rails codebases aligned with business invariants.",
        crucial: true
      },
      {
        category: "Engineering Management",
        name: "Team Leadership & Mentoring",
        description: "Grow engineers through feedback, pairing, and delegation; align individual development plans with product and organizational goals.",
        crucial: true
      },
      {
        category: "Engineering Management",
        name: "Stakeholder Communication",
        description: "Translate technical plans, risks, and trade-offs for product, leadership, and customers to maintain trust and shared prioritization.",
        crucial: true
      },
      {
        category: { parent: "Engineering Management", name: "Process planning" },
        name: "Roadmapping & Release Planning",
        description: "Sequence initiatives, define release criteria, and coordinate cross-team dependencies to deliver predictable outcomes.",
        crucial: true
      },
      {
        category: { parent: "Engineering Management", name: "Process planning" },
        name: "Risk Management & Mitigation",
        description: "Identify delivery, technical, and people risks; maintain mitigation plans and contingency triggers throughout project lifecycles.",
        crucial: true
      },
      {
        category: "Verification",
        name: "Test Strategy & Planning",
        description: "Define quality goals, testing scopes, and automation layers (unit, integration, contract) to keep regression risk in check.",
        crucial: true
      },
      {
        category: "Verification",
        name: "Performance & Load Testing",
        description: "Design and execute load, soak, and stress tests (JMeter, k6) and analyze telemetry to guard against reliability and capacity issues.",
        crucial: true
      },
      {
        category: "DB",
        name: "Data Modeling & Normalization",
        description: "Design relational schemas, normalize data, and document ERDs to maintain integrity and evolvability of persistent stores.",
        crucial: true
      },
      {
        category: "DB",
        name: "Database Performance & Indexing",
        description: "Tune queries, create composite indexes, and leverage database statistics and caching to keep data access efficient.",
        crucial: true
      },
      {
        category: "DB",
        name: "PostgreSQL Ecosystem",
        description: "Apply PostgreSQL features (JSONB, full-text search, extensions, logical replication) and manage migrations safely.",
        crucial: true
      },
      {
        category: "Web Back-End",
        name: "API Design & Integration",
        description: "Design REST and GraphQL APIs with consistent semantics, versioning, authentication, and client integration patterns.",
        crucial: true
      },
      {
        category: "Web Back-End",
        name: "Background Job Processing",
        description: "Select and operate job frameworks (Sidekiq, ActiveJob), design idempotent jobs, and monitor queues for reliability.",
        crucial: true
      },
      {
        category: "Web Back-End",
        name: "Caching & Performance Optimization",
        description: "Use Rails caching layers, Redis, CDN strategies, and HTTP caching headers to reduce latency and load on backing services.",
        crucial: true
      },
      {
        category: "Web Front-End",
        name: "Accessibility & Inclusive Design",
        description: "Implement WCAG-compliant interfaces with semantic HTML, keyboard support, and assistive technology testing.",
        crucial: true
      },
      {
        category: "Web Front-End",
        name: "Front-End Build Tooling",
        description: "Configure and maintain bundlers (Webpack, esbuild, Vite) and asset pipelines for efficient builds and deployments.",
        crucial: true
      }
    ]

    def find_or_create_category(category_config)
      if category_config.is_a?(Hash)
        parent = find_or_create_category(category_config[:parent])
        category = SkillCategory.find_or_create_by!(name: category_config[:name])
        if category.parent_category != parent
          category.update!(parent_category: parent)
        end
        category
      else
        SkillCategory.find_or_create_by!(name: category_config)
      end
    end

    levels = Level.where(name: %w[A1 A2 A3]).to_a

    missing_skills.each do |config|
      category = find_or_create_category(config[:category])
      skill = Skill.where("TRIM(name) = ?", config[:name]).first_or_initialize
      skill.skill_category = category
      skill.name = config[:name]
      skill.description = config[:description]
      skill.crucial = config.fetch(:crucial, true)
      skill.save!

      levels.each do |level|
        SkillLevel.find_or_create_by!(skill: skill, level: level) do |skill_level|
          skill_level.notice = "<div class=\"trix-content\"><div>Define expectations for #{skill.name} (#{level.title}).</div></div>"
        end
      end
    end

    puts "Reassigning legacy skills to normalized categories…"
    baseline_category_map = {
      "Web UI, Libraries and Frameworks" => "Web Front-End",
      "Automation Testing" => "Verification",
      "Cloud-based Deployment Services" => "Web Back-End",
      "Code quality" => "Verification",
      "Continuous Integration" => "Configuration Management",
      "DB Access" => "DB",
      "Managing versions" => "Configuration Management",
      "MySQL" => "DB",
      "Networking" => "Core",
      "NoSQL" => "DB",
      "Product builds and Continuous Integration" => "Configuration Management",
      "Refactoring" => "Core",
      "RSpec and Testing Libraries" => "Verification",
      "Ruby Language" => "Core",
      "Ruby On Rails" => "Web Back-End",
      "Security" => "Core",
      "SQL" => "DB",
      "Tools and Gems" => "Core",
      "Web and Application Servers" => "Web Back-End",
      "Web UI, JavaScript, HTML, CSS" => "Web Front-End"
    }

    baseline_category_map.each do |skill_name, category_name|
      skill = Skill.where("TRIM(name) = ?", skill_name).first
      next unless skill

      category = find_or_create_category(category_name)
      skill.update!(skill_category: category, name: skill_name)
    end

    puts "Normalizing skill names…"
    Skill.find_each do |skill|
      stripped = skill.name&.strip
      next if stripped.blank? || stripped == skill.name

      duplicate = Skill.find_by("TRIM(name) = ?", stripped)
      if duplicate && duplicate.id != skill.id
        SkillLevel.where(skill: skill).update_all(skill_id: duplicate.id)
        skill.destroy!
      else
        skill.update!(name: stripped)
      end
    end

    process_planning = Skill.find_by(name: "Process Planning")
    if process_planning
      process_planning.update!(name: "Process planning")
    end

    puts "Ensuring sub-category for Process planning…"
    engineering_management = SkillCategory.find_by(name: "Engineering Management")
    process_planning_category = SkillCategory.find_or_create_by!(name: "Process planning")
    if process_planning_category.parent_category != engineering_management
      process_planning_category.update!(parent_category: engineering_management)
    end
    %w[Estimation Process planning Requirements].each do |skill_name|
      skill = Skill.find_by("TRIM(name) = ?", skill_name)
      next unless skill

      skill.update!(skill_category: process_planning_category)
    end

    puts "Skill catalog sync complete."
  end
end
