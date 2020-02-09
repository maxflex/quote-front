import Vue from "vue"

const filters = {
  time(value) {
    return value.substring(0, 5)
  },

  nameInitials(user) {
    return `${user.last_name} ${user.first_name[0]}.`
  },

  nameLastFirst(user) {
    return [user.last_name, user.first_name].join(" ")
  },

  nameFull(user) {
    return [user.last_name, user.first_name, user.middle_name].join(" ")
  },
}

for (let filterName in filters) {
  Vue.filter(filterName, filters[filterName])
}
