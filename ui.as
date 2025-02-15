void RenderInterface() {
    if (!S_showPopupUI) return;
    if (S_showPopupUIWhenOpenplanetUIIsHidden) return;

    RenderPopupUI();
}

void Render() {
    if (!S_showPopupUI) return;
    if (!S_showPopupUIWhenOpenplanetUIIsHidden) return;

    RenderPopupUI();
}

CGameEditorItem@ currentEditorItem;
string currentBlockName = "";
bool currentBlockHasBeenSet = false;

// In case the UI is hidden, but we still want to automatically set the item settings
void Update(float dt) {
    if (GetApp().Editor !is null) {
        CGameEditorItem@ editorItem = cast<CGameEditorItem>(GetApp().Editor);
        if (editorItem is null) { currentBlockHasBeenSet=false; return; };
        if (editorItem !is null) { @currentEditorItem = editorItem; }
        if (GetLabel().Contains("Block name") ) { return; }

        if (S_setItemToDefaultBlockSettingsAutomatically && !currentBlockHasBeenSet) {
            currentBlockHasBeenSet = true;
            startnew(SetItemSettings);
        }
    }
}

[Setting hidden]
bool tS_showSettingsUI = true;

[Setting hidden]
vec2 collapsedPopupUIPos = vec2(75, 753);
[Setting hidden]
vec2 expandedPopupUIPos = vec2(195, 200);

void RenderPopupUI() {
    if (editorItem is null) { currentBlockHasBeenSet=false; return; };
    if (editorItem !is null) { @currentEditorItem = editorItem; };
    if (GetLabel().Contains("Block name") || GetLabel() == "") { return; }
    // Only show this in the 'block to item' tool, not in the block to block tool

    if (UI::Begin("SetItemToDefaultBlockSettings", UI::WindowFlags::NoTitleBar|UI::WindowFlags::NoResize|UI::WindowFlags::AlwaysAutoResize)) {
        UI::SetWindowPos(collapsedPopupUIPos, UI::Cond::FirstUseEver);

        if (UI::Button("Set item settings to default block settings")) {
            currentBlockHasBeenSet = true;
            startnew(SetItemSettings);
        }
        UI::SameLine();
        
        if (tS_showSettingsUI) {
            if (UI::Button(Icons::Cog + " " + Icons::ChevronDown)) {
                UI::SetWindowPos(collapsedPopupUIPos);
                tS_showSettingsUI = false;
            }
        } else {
            if (UI::Button(Icons::Cog + " " + Icons::ChevronRight)) {
                UI::SetWindowPos(expandedPopupUIPos);
                tS_showSettingsUI = true;
            }
        }
        if (tS_showSettingsUI) RT_Settings_General();
    }
    UI::End();
}

