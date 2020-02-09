export default {
  SHOW(state, { text, color = "success" }) {
    state.show = true
    state.text = text
    state.color = color
  },
}
