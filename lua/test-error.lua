-- Test script to debug error lens
local function test_error_lens()
  print("Testing error lens setup...")
  
  -- Check current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.bo[bufnr].buftype
  local filetype = vim.bo[bufnr].filetype
  local modifiable = vim.bo[bufnr].modifiable
  local readonly = vim.bo[bufnr].readonly
  
  print("Buffer info:")
  print("  bufnr: " .. bufnr)
  print("  buftype: " .. (buftype == "" and "normal" or buftype))
  print("  filetype: " .. (filetype == "" and "none" or filetype))
  print("  modifiable: " .. tostring(modifiable))
  print("  readonly: " .. tostring(readonly))
  
  -- Try to load error lens
  local ok, error_lens = pcall(require, "lsp.error-lens")
  if ok then
    print("Error lens loaded successfully")
    
    -- Try setup
    local setup_ok = pcall(error_lens.setup)
    print("  setup() result: " .. tostring(setup_ok))
    
    -- Try keymap
    local keymap_ok = pcall(error_lens.setup_keymap)
    print("  setup_keymap() result: " .. tostring(keymap_ok))
  else
    print("Failed to load error lens: " .. error_lens)
  end
end

-- Run the test
test_error_lens()
