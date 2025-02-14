void RenderInterface() {
    if (!S_showPopupUI) return;
    if (!S_showPopupUIWhenOpenplanetUIIsHidden) return;

    RenderPopupUI();
}

void Render() {
    if (!S_showPopupUI) return;
    if (S_showPopupUIWhenOpenplanetUIIsHidden) return;

    RenderPopupUI();
}

CGameEditorItem@ currentEditorItem;
string currentBlockName = "";
bool currentBlockHasBeenSet = false;

// In case the UI is hidden, but we still want to automatically set the item settings
void Update(float dt) {
    if (GetApp().Editor !is null) {
        CGameEditorItem@ editorItem = cast<CGameEditorItem>(GetApp().Editor);
        if (editorItem is null) return;
        if (editorItem !is null) { currentEditorItem = editorItem; }
        if (GetLabel().Contains("Block name") ) { return; }

        if (S_setItemToDefaultBlockSettingsAutomatically && !currentBlockHasBeenSet) {
            SetItemToDefaultBlockSettings(currentEditorItem);
            GetFrame6Button().OnAction(); // Needed to visually show that the update has happened
            currentBlockHasBeenSet = true;
        }
    }
}

[Setting hidden]
bool tS_showSettingsUI = true;

void RenderPopupUI() {
    if (GetLabel().Contains("Block name") ) { return; }
    // Only show this in the 'block to item' tool, not in the block to block tool

    if (UI::Begin("SetItemToDefaultBlockSettings", UI::WindowFlags::NoTitleBar|UI::WindowFlags::NoResize|UI::WindowFlags::AlwaysAutoResize)) {
        if (UI::Button("Set item settings to default block settings")) {
            SetItemToDefaultBlockSettings(currentEditorItem);
            GetFrame6Button().OnAction();
        }
        UI::SameLine();
        
        if (tS_showSettingsUI) {
            if (UI::Button(Icons::Cog + " " + Icons::ChevronDown)) { tS_showSettingsUI = false; }
        } else {
            if (UI::Button(Icons::Cog + " " + Icons::ChevronRight)) { tS_showSettingsUI = true; }
        }
        if (tS_showSettingsUI) RT_Settings_General();
    }
    UI::End();
}

