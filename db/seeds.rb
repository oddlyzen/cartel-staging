# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_artist1 = User.create(email: 'user@pan.com', password: '123123123', password_confirmation: '123123123', first_name: 'Mario', last_name: 'Mariana', title: 'mr', role: :artist, date_of_birth: '1990-09-09',
  nationality_country: "Malaysia", residency_status: "resident", based_country: "Malaysia", based_state: "johor", membership_id: 1,
  current_status: "Seeking Representation", commission: 0, media_tags: ["Digital", "Drawing"], subjects_tags: ['Activitism', 'Oil'], exhibit_title: "Title", participation: "Group", venue: "Kuala Lumpur",
  exhibit_country: "Malaysia", exhibit_state: "selangor", from_record_year: '2015-11-01', to_record_year: '2015-11-01', acknowledgement: 1, representation: 'Gallery Malaysia',
  tagline: "Fifty years of experience, looking for something.", statement: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce porta nec tellus id tristique.
  Ut rhoncus feugiat finibus. Quisque id mi sodales lorem rhoncus commodo. Nam ac lacus vitae nibh tincidunt tempus. Integer sed sapien quis velit dictum ornare.
  Suspendisse ut ligula ipsum. Aenean nisi odio, dictum ut purus at, aliquet placerat nulla. Nulla facilisi. Vestibulum pretium pharetra suscipit. Pellentesque ullamcorper
  ante eget augue scelerisque, at fermentum neque vehicula. Sed vel tellus sed.", skill: "Photoshop", link: "www.ronaldhunt.com", facebook_link: "www.ronaldhunt.com",
  instagram_link: "www.ronaldhunt.com", twitter_link: "www.ronaldhunt.com", from_exhibit_date: '2015-11-01', to_exhibit_date: '2015-11-01', gender: "male", based_location: "London, United Kingdom") do |user|

  user.build_profile

  user.series.build(
    title: 'Classic Collection',
    description: 'Only the classic arts',
    year: '1/1/1983'
  )

  user.artworks.build(image_url: "https://cdn.filepicker.io/api/file/6z4UHymTNegoMddWi3ly",
    title: "Starry Sky",
    height: 20,
    width: 10,
    length: 1,
    unit: 0,
    year: 2014,
    art_type: "Landscape",
    description: "A starry night"
  )

  user.artworks.build(image_url: "https://cdn.filepicker.io/api/file/2bSIOPkQOOgXyGD4zYA7",
    title: "Mona Lisa",
    height: 77,
    width: 53,
    length: 50,
    unit: 0,
    year: 2014,
    art_type: "Painting",
    description:
     "The Mona Lisa is a half-length portrait of a woman by the Italian artist Leonardo da Vinci, which has been acclaimed as \"the best known, the most visited, the most written about, the most sung about, the most parodied work of art in the world\"."
  )

  user.artworks.build(image_url: "https://cdn.filepicker.io/api/file/e9VCfROoTjGm5Vty6Cqj",
    title: "Wheat Field with Cypresses",
    height: 73,
    width: 93,
    length: 100,
    unit: 0,
    year: 2014,
    art_type: "Oil Canvas",
    description:
    "Writing to his brother Theo from the asylum in Saint-Rémy in early July 1889, Van Gogh described his latest work in the series he had begun in June: \"I have a canvas of cypresses with a few ears of wheat, poppies, a blue sky, which is like a multicolored Scotch plaid.\" Van Gogh regarded this sun-drenched landscape as one of his \"best\" summer canvases and repeated the composition three times: first in a reed pen drawing (Van Gogh Museum, Amsterdam) and then in two oil variants he made later that fall (National Gallery, London; private collection)."
  )

end

bulk_group_form_params = { user_id: user_artist1.id, series: user_artist1.series.first.id, artwork_ids: user_artist1.artworks.pluck(:id) }

BulkGroupForm.new(bulk_group_form_params).save

user_artist2 = User.create!(email: 'artist@pan.com', password: '123123123', password_confirmation: '123123123', first_name: 'Famous', last_name: 'Artist', title: 'dr', role: :artist, date_of_birth: '1990-09-09',
  nationality_country: "Malaysia", residency_status: "resident", based_country: "Malaysia", based_state: "johor", membership_id: 2,
  current_status: "Seeking Representation", commission: 0, media_tags: ["Digital", "Drawing"], subjects_tags: ['Activitism', 'Oil'], exhibit_title: "Title", participation: "Group", venue: "Kuala Lumpur",
  exhibit_country: "Malaysia", exhibit_state: "selangor", from_record_year: '2015-11-01', to_record_year: '2015-11-01', acknowledgement: 1, representation: 'Gallery Malaysia',
  tagline: "Fifty years of experience, looking for something.", statement: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce porta nec tellus id tristique.
  Ut rhoncus feugiat finibus. Quisque id mi sodales lorem rhoncus commodo. Nam ac lacus vitae nibh tincidunt tempus. Integer sed sapien quis velit dictum ornare.
  Suspendisse ut ligula ipsum. Aenean nisi odio, dictum ut purus at, aliquet placerat nulla. Nulla facilisi. Vestibulum pretium pharetra suscipit. Pellentesque ullamcorper
  ante eget augue scelerisque, at fermentum neque vehicula. Sed vel tellus sed.", skill: "Photoshop", link: "", facebook_link: "",
  instagram_link: "", twitter_link: "www.ronaldhunt.com", from_exhibit_date: '2015-11-01', to_exhibit_date: '2015-11-01', gender: "male", based_location: "London, United Kingdom") do |user|

  user.build_profile

  user.artworks.build(image_url: "https://cdn.filepicker.io/api/file/CgBsRcNQhLbqccmQzasg",
    title: "The Old Guitarist",
    height: 123,
    width: 83,
    length: 40,
    unit: 0,
    year: 2014,
    art_type: "Oil Paint",
    description:
    "The Old Guitarist was painted in 1903, just after the suicide death of Picasso's close friend, Casagemas. During this time, the artist was sympathetic to the plight of the downtrodden and painted many canvases depicting the miseries of the poor, the ill, and those cast out of society. He too knew what it was like to be impoverished, having been nearly penniless during all of 1902. This work was created in Madrid, and the distorted style (note that the upper torso of the guitarist seems to be reclining, while the bottom half appears to be sitting cross-legged) is reminiscent of the works of El Greco."
  )

  user.artworks.build(image_url: "https://cdn.filepicker.io/api/file/pZjLLpeWQgcABQ5PHnYA",
    title: "The Last Supper",
    height: 460,
    width: 880,
    length: 2,
    unit: 0,
    year: 2014,
    art_type: "tempera on gesso, pitch and mastic",
    description:
    "The Last Supper (Italian: Il Cenacolo [il tʃeˈnaːkolo] or L'Ultima Cena [ˈlultima ˈtʃeːna]) is a late 15th-century mural painting by Leonardo da Vinci in the refectory of the Convent of Santa Maria delle Grazie, Milan. It is one of the world's most famous paintings, and one of the most studied, scrutinized, and satirized."
  )

end

user_pro1 = User.create(email: 'userpro@pan.com', password: '123123123', password_confirmation: '123123123', first_name: 'John', last_name: 'Appleseed', title: 'mr', role: :professional, date_of_birth: '1990-09-09',
  nationality_country: "Malaysia", residency_status: "resident", based_country: "Malaysia", based_state: "johor",
  current_status: "Seeking Representation", commission: 0, specialisations_tags: ["Contemporary Art", "Asian Art"], exhibit_title: "Title", participation: "Group", venue: "Kuala Lumpur",
  exhibit_country: "Malaysia", exhibit_state: "selangor", from_record_year: '2015-11-01', to_record_year: '2015-11-01', acknowledgement: 1,
  tagline: "Fifty years of experience, looking for something.", statement: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce porta nec tellus id tristique.
  Ut rhoncus feugiat finibus. Quisque id mi sodales lorem rhoncus commodo. Nam ac lacus vitae nibh tincidunt tempus. Integer sed sapien quis velit dictum ornare.
  Suspendisse ut ligula ipsum. Aenean nisi odio, dictum ut purus at, aliquet placerat nulla. Nulla facilisi. Vestibulum pretium pharetra suscipit. Pellentesque ullamcorper
  ante eget augue scelerisque, at fermentum neque vehicula. Sed vel tellus sed.", skill: "Photoshop", link: "www.ronaldhunt.com", facebook_link: "www.ronaldhunt.com",
  instagram_link: "www.ronaldhunt.com", twitter_link: "www.ronaldhunt.com", position: 'Junior Artist', company_name: 'Museum Company', exhibit_description: 'Lorem ipsum dolor sit amet, convallis quam.
', from_exhibit_date: '2015-11-01', to_exhibit_date: '2015-11-01', gender: "male", based_location: "London, United Kingdom") do |user|

  user.build_profile
end

user_admin = User.create!(email: 'admin@pan.com', password: '123123123', password_confirmation: '123123123', first_name: 'PAN', last_name: 'Admin', title: 'mr', role: :admin, gender: "male", based_location: "London, United Kingdom", date_of_birth: '1990-09-09', current_status: "Seeking Representation")

%w(Acrylic\ Paint Bronze Ceramics Chalk Charcoal Clay Conté Crayon Gouache Graphite Marble Marker Oil\ Paint Pastel Pen\ and\ ink Pencil Stone Watercolour Wood Other).each do |medium|
  Medium.create!(name: medium, user_id: user_admin.id, state: :approved, set_display: true)
end

%w(Abstract Flora\ &\ Fauna Landscape Mythology Nudes Pastoral Politics Portraiture Religious Self-Portrait Still\ Life Textual Vanitas).each do |subject|
  Subject.create!(name: subject, user_id: user_admin.id, state: :approved, set_display: true)
end

%w(Post-War\ &\ Contemporary\ Art Modern\ Art Chinese\ Art Modern\ &\ Contemporary\ Chinese\ Art Southeast\ Asian\ Art Modern\ &\ Contemporary\ Southeast\ Asian\ Art).each do |specialisation|
  Specialisation.create!(name: specialisation, user_id: user_admin.id, state: :approved)
end

%w(Adobe\ Illustrator Adobe\ InDesign Adobe\ Photoshop Print-Making).each do |skill|
  Skill.create!(name: skill, user_id: user_admin.id, state: :approved)
end

%w(Acquisition Advertising Appraisal Art\ Direction Art\ Writing Catalogue\ Design Consultation Copy\ writing Curating Editing Events\ Management Framing Installation Investments Legal Marketing Organisational\ Management Project\ Management Valuation).each do |service|
  Service.create(name: service, user_id: user_admin.id, state: :approved)
end

%w(Politics Economy).each do |interest|
  Interest.create!(name: interest, user_id: user_admin.id, state: :approved)
end

%w(English Chinese Japanese).each do |language|
  Language.create!(name: language, user_id: user_admin.id, state: :approved)
end

%w(Art\ Dealership Art\ Fund Art\ Movers Auction\ House Award\ Body Charity/NGO Consultancy Educational Event\ Venue Framers Gallery Legal\ Services Museum Residency Restoration Small\ Business Technical Valuation Other).each do |organization_type|
  OrganizationType.create!(name: organization_type, user_id: user_admin.id, state: :approved, public_option: true)
end

# get from excel this list, row[0] = university name, row[1] = location

%w(Brown\ University Camberwell\ College\ of\ Arts Central\ Saint\ Martins Chelsea\ College\ of\ Art\ and\ Design Christie's\ Education Columbia\ University Cornell\ University Courtauld\ Institute\ of\ Art Dasein\ Academy\ of\ Art De\ Ateliers Duke\ University Gerrit\ Rietveld\ Academie Goldsmiths\ College Harvard\ University LASALLE\ College\ of\ the\ Arts Malaysian\ Institute\ of\ Art Monash\ University  Nanyang\ Academy\ of\ Fine\ Arts NTU\ School\ of\ Art,\ Design\ and\ Media\ (ADM) National\ University\ of\ Singapore New\ York\ University Pratt\ Institute Princeton\ University Rijksakademie\ van\ beeldende\ kunsten Royal\ Academy\ of\ Arts Royal\ College\ of\ Art  Sandberg\ Instituut School\ of\ Oriental\ and\ African\ Studies\ (SOAS) Slade\ School\ of\ Art Sotheby's\ Institute\ of\ Art The\ Ruskin\ School\ of\ Fine\ Art\ and\ Drawing Universiti\ Teknologi\ MARA\ (UITM) University\ College\ London University\ of\ California,\ Los\ Angeles\ (UCLA) University\ of\ Cambridge University\ of\ Chicago University\ of\ Edinburgh University\ of\ Glasgow University\ of\ Hong\ Kong University\ of\ Oxford Warburg\ Institute Williams\ College Wimbledon\ College\ of\ Art Winchester\ School\ of\ Art Yale\ University).each do |univ|
  Institution.create!(name: univ)
end

user_artist1.connections.build(friend: user_artist2).save
user_artist1.connections.build(friend: user_pro1).save
user_artist2.connections.build(friend: user_pro1).save

company1 = Company.create!(name: 'Art Galleria', email: 'art@galleria.com', phone: '+60196467110', website: 'www.artgalleria.com', country: 'Malaysia', state: 'Penang', motto: 'Arts is life', established_in: 5.years.ago, address_1: 'Address Line 1', address_2: 'Address Line 2', location: 'Location1', about_us: "Test", postcode: "AB12 5JX", organization_type_ids: [OrganizationType.first.id]) do |company|
  company.owner = company.members.build(email: 'pro1@pan.com', password: '123123123', password_confirmation: '123123123', first_name: 'pro', last_name: 'final', title: 'mr', role: :professional, gender: "male", based_location: "London, United Kingdom", date_of_birth: '1990-09-09', current_status: "Seeking Representation") do |member|
    member.build_profile
  end

  company.company_memberships.build(user: user_artist2, state: :pending)
  company.company_memberships.build(user: user_pro1, state: :pending)
end


company2 = Company.create!(name: 'Lisson Gallery', email: 'art@lisson.com', phone: '+60196333110', website: 'www.lisson.com', country: 'Singapore', state: 'Bugis', motto: 'Age Quod Agis', established_in: 5.years.ago, address_1: 'Address Line 1', address_2: 'Address Line 2', location: 'Location1', about_us: "Test", postcode: "AB12 5JX", organization_type_ids: [OrganizationType.first.id])

CompanyMembership.create!(user_id: user_artist1.id, company_id: company1.id)
CompanyMembership.create!(user_id: user_artist2.id, company_id: company1.id)
