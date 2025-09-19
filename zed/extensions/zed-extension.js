// zed-extension.js
import { registerCommand } from "@zed.dev/zed-extension-api";

registerCommand("local-llm", async (editor) => {
  const code = editor.getSelection() || editor.getDocumentText();

  const response = await fetch("http://127.0.0.1:11434/generate", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      prompt: code,
      max_new_tokens: 200,
    }),
  });

  const data = await response.json();
  editor.insertTextAtCursor(data.text);
});
