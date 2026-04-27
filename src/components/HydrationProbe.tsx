import { useState } from "react";

/**
 * Tiny React island used to verify @astrojs/react is wired up correctly.
 * Hydration is working if the count increments on click.
 *
 * Once the DuckDB-Wasm explorer is built, this file can be deleted.
 */
export default function HydrationProbe() {
  const [count, setCount] = useState(0);

  return (
    <div
      style={{
        background: "#fef9c3",
        border: "1px dashed #ca8a04",
        borderRadius: 8,
        padding: "0.75rem 1rem",
        margin: "1rem 0",
        fontFamily: "sans-serif",
        fontSize: "0.9rem",
        color: "#713f12",
      }}
    >
      <strong>React island:</strong> hydration probe — clicks: {count}{" "}
      <button
        type="button"
        onClick={() => setCount((c) => c + 1)}
        style={{
          marginLeft: "0.5rem",
          padding: "0.2rem 0.6rem",
          border: "1px solid #ca8a04",
          borderRadius: 4,
          background: "white",
          cursor: "pointer",
        }}
      >
        +1
      </button>
    </div>
  );
}
