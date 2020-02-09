export default {
  props: {
    id: {
      type: Number,
      required: false,
    },
  },

  data() {
    return {
      item: undefined,
    }
  },

  created() {
    this.loadData()
  },

  methods: {
    loadData() {
      this.$http
        .get([this.API_URL, this.id || this.$route.params.id].join("/"))
        .then(({ data }) => {
          this.item = data
        })
    },

    updated({ item }) {
      this.item = item
    },
  },
}
