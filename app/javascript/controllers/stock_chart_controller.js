import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";

Chart.register(...registerables);

export default class extends Controller {
  static targets = ["canvas"];
  static values = { labels: Array, values: Array };

  connect() {
    const { bgColors, borderColors } = colorsFromLabels(this.labelsValue);

    this.chart = new Chart(this.canvasTarget, {
      type: "bar",
      data: {
        labels: this.labelsValue,
        datasets: [
          {
            label: "€",
            data: this.valuesValue,
            backgroundColor: bgColors, // rgba(..., 0.2)
            borderColor: borderColors, // rgb(...)
            borderWidth: 1,
          },
        ],
      },
      options: {
        responsive: true,
        plugins: {
          legend: { display: false },
          tooltip: {
            callbacks: {
              label: (ctx) => `${ctx.raw.toLocaleString("fr-FR")} €`,
            },
          },
        },
        scales: {
          y: {
            ticks: {
              callback: (v) => `${v.toLocaleString("fr-FR")} €`,
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

/**
 * Génère des couleurs type Chart.js docs :
 * - background: rgba(r,g,b,0.2)
 * - border: rgb(r,g,b)
 * Unique par label, stable dans le temps.
 */
function colorsFromLabels(labels) {
  const used = new Set();
  const bgColors = [];
  const borderColors = [];

  for (const label of labels) {
    let rgb = rgbFromString(label);

    // évite un doublon exact (rare) : on décale un peu le "hash"
    let key = `${rgb.r},${rgb.g},${rgb.b}`;
    let bump = 0;
    while (used.has(key)) {
      bump += 17;
      rgb = rgbFromString(label + bump);
      key = `${rgb.r},${rgb.g},${rgb.b}`;
    }
    used.add(key);

    borderColors.push(`rgb(${rgb.r}, ${rgb.g}, ${rgb.b})`);
    bgColors.push(`rgba(${rgb.r}, ${rgb.g}, ${rgb.b}, 0.2)`);
  }

  return { bgColors, borderColors };
}

// Hash simple -> couleur agréable (évite les tons trop sombres/clairs)
function rgbFromString(str) {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    hash = str.charCodeAt(i) + ((hash << 5) - hash);
    hash |= 0;
  }

  // HSL -> RGB pour avoir des couleurs “propres”
  const h = Math.abs(hash) % 360;
  const s = 70; // saturation
  const l = 55; // luminosité

  return hslToRgb(h / 360, s / 100, l / 100);
}

function hslToRgb(h, s, l) {
  const hue2rgb = (p, q, t) => {
    if (t < 0) t += 1;
    if (t > 1) t -= 1;
    if (t < 1 / 6) return p + (q - p) * 6 * t;
    if (t < 1 / 2) return q;
    if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
    return p;
  };

  let r, g, b;
  if (s === 0) {
    r = g = b = l;
  } else {
    const q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    const p = 2 * l - q;
    r = hue2rgb(p, q, h + 1 / 3);
    g = hue2rgb(p, q, h);
    b = hue2rgb(p, q, h - 1 / 3);
  }

  return {
    r: Math.round(r * 255),
    g: Math.round(g * 255),
    b: Math.round(b * 255),
  };
}
