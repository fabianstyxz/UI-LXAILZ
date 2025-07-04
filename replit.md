# Replit.md

## Overview

This repository contains a comprehensive Roblox UI Library that completely replicates all Rayfield functionality with a custom modern, dark, minimalist design. The library is built with Lua and features a fully modular architecture compatible with loadstring() execution.

## System Architecture

**Current State**: Complete modular UI library implementation for Roblox.

**Architecture Components**:
- **Main.lua**: Entry point and library initialization
- **Modules/**: Organized component system with individual modules
- **Utils.lua**: Utility functions and compatibility layer
- **Theme.lua**: Comprehensive theming system
- **Component System**: All interactive UI elements (Toggle, Slider, Button, etc.)
- **Advanced Systems**: Notifications, KeySystem, LoadingScreen, ConfigManager

## Key Components

**Implemented Components**:
1. **Window System**: CreateWindow with loading screens and configuration
2. **Tab System**: CreateTab with navigation and organization
3. **Interactive Components**: 
   - CreateToggle: Toggle switches with callbacks
   - CreateSlider: Value sliders with min/max ranges
   - CreateButton: Interactive buttons with ripple effects
   - CreateInput: Text input fields with validation
   - CreateDropdown: Single/multi-select dropdowns
   - CreateColorPicker: Full HSV color picker
   - CreateKeybind: Key binding with hold mode support
   - CreateParagraph: Rich text paragraphs
   - CreateLabel: Simple text labels
   - CreateDivider: Section dividers
4. **Notification System**: Animated notifications with multiple types
5. **Key System**: Complete key verification with Discord integration
6. **Loading Screen**: Animated loading with typewriter effects
7. **Config Manager**: JSON-based configuration saving/loading
8. **Discord Prompt**: Modal invitation system
9. **Floating Button**: Draggable mobile-compatible button
10. **Theme System**: Multiple themes (Dark, Light, Neon) with custom creation

## Data Flow

**Current Implementation**:
1. Library initialization loads all modules
2. CreateWindow establishes main UI container
3. CreateTab creates navigation and content areas
4. Component creation adds interactive elements
5. Callback system handles user interactions
6. Theme system manages consistent styling
7. Advanced systems provide enhanced functionality

## External Dependencies

**Roblox Services Required**:
- TweenService: For smooth animations
- UserInputService: For input handling and platform detection
- RunService: For frame-based operations
- HttpService: For key validation and configuration
- TextService: For text size calculations
- GuiService: For UI management
- Players: For player-specific functionality

## Deployment Strategy

**Current Strategy**: 
- **Development**: Local Lua testing environment with mock services
- **Production**: Direct deployment to Roblox via loadstring()
- **Distribution**: Single-file execution or modular loading
- **Compatibility**: Full Rayfield API compatibility for easy migration

## Changelog

```
Changelog:
- July 04, 2025: Complete library implementation and migration
  - All Rayfield functions replicated with exact API compatibility
  - Modern, dark, minimalist design with TweenService animations
  - Full modular architecture with organized component system
  - Advanced systems: Notifications, KeySystem, LoadingScreen, ConfigManager
  - Theme system with multiple presets and custom creation
  - Mobile-responsive design with touch support
  - Compatible with loadstring() execution
  - Main_LoadString.lua fixed and fully functional with all components
  - Added comprehensive mock environment for local testing
  - Successfully migrated from Replit Agent to Replit environment
  - All 11 component types verified working: Toggle, Slider, Button, Input, Dropdown, ColorPicker, Keybind, Paragraph, Label, Divider
  - Callback and flag systems operational
  - Ready for Roblox deployment
```

## User Preferences

```
Preferred communication style: Simple, everyday language.
Project Focus: Complete Rayfield functionality replication
Design Choice: Modern, dark, minimalist style (not copying Rayfield's visual design)
Technical Requirements: 
- Modular architecture
- loadstring() compatibility
- Mobile device support
- TweenService animations
- Typewriter effects for titles
- F key default for show/hide
```

## Development Guidelines

**Current Implementation Standards**:

1. **Code Organization**: Modular structure with Modules/ directory
2. **API Compatibility**: Exact Rayfield function signatures and behavior
3. **Design Consistency**: Modern dark theme with consistent spacing and typography
4. **Performance**: Efficient memory usage with proper cleanup
5. **Mobile Support**: Touch-friendly interactions and responsive layout
6. **Animation**: Smooth TweenService animations for all interactions
7. **Documentation**: Comprehensive inline documentation and examples

## Features Summary

**Complete Rayfield Replication**:
- ✅ All CreateWindow functionality
- ✅ All CreateTab functionality  
- ✅ All interactive components (Toggle, Slider, Button, Input, Dropdown, ColorPicker, Keybind, Paragraph, Label, Divider)
- ✅ Notification system with animations
- ✅ Key system with Discord integration
- ✅ Loading screen with typewriter effects
- ✅ Configuration management with JSON support
- ✅ Discord prompt system
- ✅ Floating button with mobile support
- ✅ Multi-theme system with custom creation
- ✅ Global keybind system (F key default)
- ✅ Mobile-responsive design
- ✅ Compatible with loadstring() execution

**Enhanced Features**:
- Modern, dark, minimalist design aesthetic
- Fluid TweenService animations throughout
- Advanced mobile touch support
- Comprehensive utility system
- Modular architecture for customization
- Enhanced error handling and validation

## Next Steps

The library is complete and ready for deployment. Future enhancements could include:
1. Additional theme presets
2. Extended animation options
3. Advanced mobile gestures
4. Plugin system for custom components
5. Performance optimizations for large-scale usage