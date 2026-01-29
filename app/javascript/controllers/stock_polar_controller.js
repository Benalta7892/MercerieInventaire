// app/javascript/controllers/stock_polar_controller.js
import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";

Chart.register(...registerables);

export default class extends Controller {
  static targets = ["canvas"];
  static values = { labels: Array, values: Array };

  connect() {
    this.chart = new Chart(this.canvasTarget, {
      type: "polarArea",
      data: {
        labels: this.labelsValue,
        datasets: [{ data: this.valuesValue, borderWidth: 1 }],
      },
      options: {
        responsive: true,
        plugins: {
          legend: { position: "bottom" },
          tooltip: {
            callbacks: {
              label: (ctx) =>
                `${ctx.label}: ${ctx.raw.toLocaleString("fr-FR")} €`,
            },
          },
        },
        scales: {
          r: {
            ticks: {
              callback: (v) => `${Number(v).toLocaleString("fr-FR")} €`,
            },
          },
        },
      },
    });
  }

  disconnect() {
    if (this.chart) this.chart.destroy();
  }
}
