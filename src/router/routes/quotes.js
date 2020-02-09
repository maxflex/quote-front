import QuoteIndex from "@/pages/Quote/Index"
import QuoteShow from "@/pages/Quote/Show"

export default [
  {
    path: "/",
    component: QuoteIndex,
  },
  {
    path: "/quotes",
    name: "QuoteIndex",
    component: QuoteIndex,
  },
  {
    path: "/quotes/:id",
    name: "QuoteShow",
    component: QuoteShow,
  },
]
