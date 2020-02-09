<template>
  <v-list dense nav>
    <v-list-item-group color="secondary">
      <MenuItem v-for="(item, index) in menu" :key="index" :item="item" />
    </v-list-item-group>
  </v-list>
</template>

<script>
import MenuItem from "./Item"

export default {
  components: { MenuItem },

  data: () => ({
    menu: [
      {
        link: "CompanyIndex",
        icon: "business",
        title: "Компании",
      },
      {
        title: "Клиенты",
        icon: "how_to_reg",
        link: "ClientIndex",
      },
      {
        link: "EmployeeIndex",
        icon: "people",
        title: "Сотрудники",
      },
      {},
      {
        link: "AdminIndex",
        icon: "person",
        title: "Администраторы",
      },
    ],
  }),
}
</script>
