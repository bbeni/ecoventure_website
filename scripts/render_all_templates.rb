require 'liquid'
require 'csv'

home_content       = 'templates/home_content.html'
about_content      = 'templates/about_content.html'

layout_template    = 'templates/layout.liquid'
projects_template  = 'templates/projects.liquid'
platforms_template = 'templates/platforms.liquid'

@layout_template = Liquid::Template.parse(File.read(layout_template))

home = @layout_template.render({'content' => File.read(home_content)})
about = @layout_template.render({'content' => File.read(about_content)})

@proj_template = Liquid::Template.parse(File.read(projects_template))
@plat_template = Liquid::Template.parse(File.read(platforms_template))

# TODO: migrate to real Database
projects_data = []
CSV.foreach("content/projects.csv", headers: true) do |row|
	projects_data << row.to_hash
end
projects_content = @proj_template.render({'projects' => projects_data})
projects = @layout_template.render({'content' => projects_content})

# TODO: migrate to real Database
platforms_data = []
CSV.foreach("content/platforms.csv", headers: true) do |row|
	platforms_data << row.to_hash
end
platforms_content = @plat_template.render({'platforms' => platforms_data})
platforms = @layout_template.render({'content' => platforms_content})



File.write('site/home.html', home)
File.write('site/about.html', about)

File.write('site/projects.html', projects)
File.write('site/platforms.html', platforms)
