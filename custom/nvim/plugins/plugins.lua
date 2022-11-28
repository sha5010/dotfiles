local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- My plugins here
  use 'nathom/filetype.nvim'            -- faster loading filetypes

  -- IME control
  local is_wsl = not not (vim.env.WSLENV or vim.env.WSL_DISTRO_NAME or vim.env.WSL_INTEROP)
  if is_wsl then
    vim.g.spzenhan = 1
  end
  use({'kaz399/spzenhan.vim',
    disable = not is_wsl,
  })
  use({'brglng/vim-im-select',
    disable = is_wsl,
  })

  use 'gbprod/substitute.nvim'          -- use operator when replacing
  use 'kylechui/nvim-surround'           -- surrounding

  -- highlight ranges in cmdline
  use 'winston0410/cmd-parser.nvim'
  use 'winston0410/range-highlight.nvim'

  use 'monaqa/dial.nvim'                -- extend increasing and decreasing

  -- neovim only
  local is_vscode = not not vim.g.vscode
  use({'ellisonleao/gruvbox.nvim',      -- prefered colorscheme
    disable = is_vscode,
  })

  use({'kyazdani42/nvim-web-devicons',  -- visual icons
    disable = is_vscode,
  })

  -- treesitter
  use({'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    disable = is_vscode,
  })

  use({'windwp/nvim-autopairs',         -- auto closing
    disable = is_vscode,
  })
  use({'windwp/nvim-ts-autotag',        -- auto closing
    disable = is_vscode,
  })
  use({'NvChad/nvim-colorizer.lua',     -- visualize color code
    disable = is_vscode,
  })

  use({'nvim-lualine/lualine.nvim',     -- status bar
    disable = is_vscode,
  })
  use({'kyazdani42/nvim-tree.lua',      -- tree filer
    disable = is_vscode,
  })
  use({'akinsho/toggleterm.nvim',       -- terminal extension
    disable = is_vscode,
  })

  -- telescope
  use({'nvim-lua/popup.nvim',
    disable = is_vscode,
  })
  use({'nvim-lua/plenary.nvim',
    disable = is_vscode,
  })
  use({'nvim-telescope/telescope.nvim',
    disable = is_vscode,
  })
  use({'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    disable = is_vscode,
  })

  use({'numToStr/Comment.nvim',         -- comment
    disable = is_vscode,
  })
  use({'cappyzawa/trim.nvim',           -- trailing space
    disable = is_vscode,
  })
  use({'lukas-reineke/indent-blankline.nvim',  -- indent
    disable = is_vscode,
  })

  -- tabline (bufferline)
  use({'akinsho/bufferline.nvim',
    disable = is_vscode,
  })

  -- undotree
  use({'mbbill/undotree',
    disable = is_vscode,
  })


  -- vscode only
  use({'asvetliakov/vim-easymotion',
    disable = not is_vscode
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

