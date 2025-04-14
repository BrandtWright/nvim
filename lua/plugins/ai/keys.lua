return {
  {
    "<leader>aa",
    function()
      vim.cmd("ChatGPT")
    end,
    desc = "Open",
  },
  {
    "<leader>ac",
    function()
      vim.cmd("ChatGPT")
    end,
    desc = "Open",
  },
  {
    "<leader>ad",
    function()
      vim.cmd("ChatGPTRun docstring")
    end,
    desc = "Doc String",
    mode = { "n", "x" },
  },
  {
    "<leader>ae",
    function()
      vim.cmd("ChatGPTRun explain_code")
    end,
    desc = "Explain Code",
    mode = { "n", "x" },
  },
  {
    "<leader>af",
    function()
      vim.cmd("ChatGPTRun fix_bugs")
    end,
    desc = "Fix Bugs",
    mode = { "n", "x" },
  },
  {
    "<leader>ag",
    function()
      vim.cmd("ChatGPTRun grammar_correction")
    end,
    desc = "Grammar Check",
    mode = { "n", "x" },
  },
  {
    "<leader>ai",
    function()
      vim.cmd("ChatGPTEditWithInstructions")
    end,
    desc = "Edit with Instructions",
    mode = { "n", "x" },
  },
  {
    "<leader>ak",
    function()
      vim.cmd("ChatGPTRun keywords")
    end,
    desc = "Keywords",
    mode = { "n", "x" },
  },
  {
    "<leader>ao",
    function()
      vim.cmd("ChatGPTRun optimize_code")
    end,
    desc = "Optimize Code",
    mode = { "n", "x" },
  },
  {
    "<leader>ar",
    function()
      vim.cmd("ChatGPTRun code_readability_analysis")
    end,
    desc = "Code Readability Analysis",
    mode = { "n", "x" },
  },
  {
    "<leader>aR",
    function()
      vim.cmd("ChatGPTRun roxygen_edit")
    end,
    desc = "Roxygen Edit",
    mode = { "n", "x" },
  },
  {
    "<leader>as",
    function()
      vim.cmd("ChatGPTRun summarize")
    end,
    desc = "Summarize",
    mode = { "n", "x" },
  },
  {
    "<leader>at",
    function()
      vim.cmd("ChatGPTRun add_tests")
    end,
    desc = "Add Tests",
    mode = { "n", "x" },
  },
}
