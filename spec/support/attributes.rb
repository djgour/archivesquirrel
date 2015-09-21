def item_attributes(overrides = {})
  {
    name: "232 Avenue Street",
    level: "item",
    description: "Photograph of 232 Avenue Street taken in 1949."
  }.merge(overrides)
end


def user_attributes(overrides = {})
  {
    name: "Joe Example",
    login: "joe_eg",
    password: "passw0rd",
    password_confirmation: "passw0rd",
    description: "A researcher with the Example project! 2nd year MI student.",
    email: "joe@example.com",
    admin: false
  }.merge(overrides)
end

def project_attributes(overrides = {})
  {
    name: "Example Project",
    description: "An example project created in ArchiveSquirrel"
  }
end
