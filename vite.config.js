import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { Schema, ValidateEnv } from "@julr/vite-plugin-validate-env";


// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react({
      include: ["**/*.res.mjs"],
    }),
    ValidateEnv({
      VITE_APP_TITLE: Schema.string(),
      VITE_API_URL: Schema.string(),
    }),
  ],
});
