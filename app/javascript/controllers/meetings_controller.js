import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "todayIndicator",
  ]

  connect() {
    this.scrollTodayIntoView();
  }

  scrollTodayIntoView() {
    if (this.hasTodayIndicatorTarget) {
      let options = {
        rootMargin: "0px",
        threshold: [0.5],
      };

      let observer = new IntersectionObserver(this.scrollMore, options);
      observer.observe(this.todayIndicatorTarget);

      this.todayIndicatorTarget.scrollIntoView({behavior: "smooth", block: "end"})
    }
  }

  scrollMore(entries, observer) {
    // Scroll a little bit more when the entry comes into view
    entries.forEach(entry => {
      if (entry.intersectionRatio === 0) {
        entry.target.needsMore = true;
      }

      if (entry.target.needsMore && entry.intersectionRatio > 0) {
        window.scrollBy(0, 75);
        observer.unobserve(entry.target)
      }
    })
  }
}
