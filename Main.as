[Setting category="general" name="Show UI"]
bool S_showUI = true;

[Setting category="general" name="Set item to default block settings automatically"]
bool S_setItemToDefaultBlockSettingsAutomatically = false;

bool currentBlockHasBeenSet = false;

void RenderInterface() {
    if (!S_showUI) return;
    CGameEditorItem@ editorItem = cast<CGameEditorItem>(GetApp().Editor);
    if (editorItem is null) { currentBlockHasBeenSet = false; return; }
    if (GetLabel().Contains("Block name") ) { return; }

    if (S_setItemToDefaultBlockSettingsAutomatically) {
        SetItemToDefaultBlockSettings(editorItem);
        currentBlockHasBeenSet = false;
    }

    if (UI::Begin("SetItemToDefaultBlockSettings", UI::WindowFlags::NoTitleBar|UI::WindowFlags::NoResize|UI::WindowFlags::AlwaysAutoResize)) {
        if (UI::Button("Set to default block settings")) {
            SetItemToDefaultBlockSettings(editorItem);
        }
        UI::SameLine();
        S_setItemToDefaultBlockSettingsAutomatically = UI::Checkbox("  Auto", S_setItemToDefaultBlockSettingsAutomatically);
    }
    UI::End();
}

void SetItemToDefaultBlockSettings(CGameEditorItem@ editorItem) {
    editorItem.PlacementParamFlyStep = 8;
    editorItem.PlacementParamGridHorizontalSize = 32;
    editorItem.PlacementParamGridHorizontalOffset = 16;
    editorItem.PlacementParamGridVerticalSize = 8;
    editorItem.PlacementParamGhostMode = true;
    editorItem.PlacementParamPivotSnapDistance = 8;

    editorItem.ItemModel.DefaultPlacementParam_Content.m_PivotPositions.RemoveRange(0, editorItem.ItemModel.DefaultPlacementParam_Content.m_PivotPositions.Length);
    editorItem.ItemModel.DefaultPlacementParam_Content.m_PivotPositions.Add(vec3(16, 0, 16));
}

string GetLabel() {
    CDx11Viewport@ viewport = cast<CDx11Viewport>(GetApp().Viewport);
    CHmsZoneOverlay@ overlay = cast<CHmsZoneOverlay>(viewport.Overlays[2]);
    CSceneSector@ sector = cast<CSceneSector>(overlay.UserData);
    CScene2d@ scene = cast<CScene2d>(sector.Scene);
    CControlFrameStyled@ frame = cast<CControlFrameStyled>(scene.Mobils[0]);
    CControlFrame@ frame2 = cast<CControlFrame>(frame.Childs[0]);  // InterfaceRoot
    CControlFrame@ frame3 = cast<CControlFrame>(frame2.Childs[4]); // FrameClassEditor
    CControlFrame@ frame4 = cast<CControlFrame>(frame3.Childs[1]); // FramePropertiesContainer
    CControlFrame@ frame5 = cast<CControlFrame>(frame4.Childs[0]); // FrameProperties
    CControlListCard@ listCard = cast<CControlListCard>(frame5.Childs[1]); // ListCardProperties
    CControlFrame@ frame6 = cast<CControlFrame>(listCard.Childs[9]); // #6
    CControlLabel@ label = cast<CControlLabel>(frame6.Childs[0]); // LabelName
    
    return label.Label;
}