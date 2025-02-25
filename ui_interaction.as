void SetItemSettings() {
    CGameEditorItem@ editorItem = currentEditorItem;
    if (editorItem is null) return;

    // Placement Parameters
    editorItem.PlacementParamSwitchPivotManually = mS_SwitchPivotManually;
    editorItem.ItemModel.DefaultPlacementParam_Content.SwitchPivotManually = mS_SwitchPivotManually;
    
    editorItem.PlacementParamFlyStep = mS_FlyStep;
    editorItem.ItemModel.DefaultPlacementParam_Content.FlyStep = mS_FlyStep;
    editorItem.PlacementParamFlyOffset = mS_FlyOffset;
    editorItem.ItemModel.DefaultPlacementParam_Content.FlyOffset = mS_FlyOffset;

    editorItem.PlacementParamGridHorizontalSize = mS_GridHorizontalSize;
        // editorItem.ItemModel.DefaultPlacementParam_Content.GridSnap_HStep = mS_GridHorizontalSize;
    editorItem.PlacementParamGridHorizontalOffset = mS_GridHorizontalOffset;
        // editorItem.ItemModel.DefaultPlacementParam_Content.GridSnap_HOffset = mS_GridHorizontalOffset;
    editorItem.PlacementParamGridVerticalSize = mS_GridVerticalSize;
        // editorItem.ItemModel.DefaultPlacementParam_Content.GridSnap_VStep = mS_GridVerticalSize;
    editorItem.PlacementParamGridVerticalOffset = mS_GridVerticalOffset;
        // editorItem.ItemModel.DefaultPlacementParam_Content.GridSnap_VOffset = mS_GridVerticalOffset;

    editorItem.PlacementParamGhostMode = mS_GhostMode;
    editorItem.ItemModel.DefaultPlacementParam_Content.GhostMode = mS_GhostMode;
    editorItem.PlacementParamYawOnly = mS_YawOnly;
    editorItem.ItemModel.DefaultPlacementParam_Content.YawOnly = mS_YawOnly;
    editorItem.PlacementParamNotOnObject = mS_NotOnObject;
    editorItem.ItemModel.DefaultPlacementParam_Content.NotOnObject = mS_NotOnObject;
    editorItem.PlacementParamAutoRotation = mS_AutoRotation;
    editorItem.ItemModel.DefaultPlacementParam_Content.AutoRotation = mS_AutoRotation;

    editorItem.PlacementParamPivotSnapDistance = mS_PivotSnapDistance;
    editorItem.ItemModel.DefaultPlacementParam_Content.PivotSnap_Distance = mS_PivotSnapDistance;

    // Pivot Positions
    editorItem.ItemModel.DefaultPlacementParam_Content.m_PivotPositions.RemoveRange(0, editorItem.ItemModel.DefaultPlacementParam_Content.m_PivotPositions.Length);

    vec3 pivotPosition = vec3(mS_PivotPositions_X, mS_PivotPositions_Y, mS_PivotPositions_Z);
    editorItem.ItemModel.DefaultPlacementParam_Content.m_PivotPositions.Add(pivotPosition);

    // Icon Direction
    // editorItem.ItemModel.IconQuarterRotationY = ; // probably where the icon rotation is stored.
    // editorItem.ItemModel.IconUseAutoRender = ; // dictates which one we should use... (from CPlugFile or auto-generated)
    
    // ABORT THIS MIGHT NOT BE THE CORRECT WAY TO GET THIS INFO... IT MIGHT JUST BE THE ROTATION OF THE BLOCK... 
    // noticed it when editing the block rotation on some of the penalty road blocks...

    SetIconSettings(editorItem.ItemModel.IconQuarterRotationY);

    GetFrame6Button().OnAction(); // Needed to visually show that the update has happened
}

void SetIconSettings(uint iconRotation) {
    yield();
    GetNewIconButton().OnAction(); // Click the new icon button
    yield();

    // Find where in the UI this is set, and choose button 2/3/4/5 depending on the rotation

    // 0 = Sourth East
    // 1 = North East
    // 2 = North West
    // 3 = South West

    CControlGrid@ grid = GetEditIconGrid();
    if (grid is null) { return; }

    CGameControlCardGeneric@ card;

    switch(mS_enumIconDirection(selectedDirection)) {
        case mS_enumIconDirection::Automatic:
            @card = cast<CGameControlCardGeneric>(grid.Childs[iconRotation+1]);
            break;
        case mS_enumIconDirection::ImportFromFile:
            @card = cast<CGameControlCardGeneric>(grid.Childs[0]);
            break;
        case mS_enumIconDirection::SouthEast:
            @card = cast<CGameControlCardGeneric>(grid.Childs[1]);
            break;
        case mS_enumIconDirection::NorthEast:
            @card = cast<CGameControlCardGeneric>(grid.Childs[2]);
            break;
        case mS_enumIconDirection::NorthWest:
            @card = cast<CGameControlCardGeneric>(grid.Childs[3]);
            break;
        case mS_enumIconDirection::SouthWest:
            @card = cast<CGameControlCardGeneric>(grid.Childs[4]);
            break;
    }

    CControlButton@ button = cast<CControlButton>(card.Childs[0]);
    button.OnAction();
}

string GetLabel() {
    CDx11Viewport@ viewport = cast<CDx11Viewport>(GetApp().Viewport);
    CHmsZoneOverlay@ overlay = cast<CHmsZoneOverlay>(viewport.Overlays[2]);
    if (overlay.UserData is null) { return ""; } // In case we are not editing an item
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

CControlButton@ GetFrame6Button() {
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
    CControlButton@ button = cast<CControlButton>(frame6.Childs[3]);

    return button;
}

CControlButton@ GetNewIconButton() {
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


    CControlFrame@ frame6;
    for (uint i = 0; i < listCard.Childs.Length; i++) {
        CControlFrame@ candidate = cast<CControlFrame>(listCard.Childs[i]);
        if (candidate !is null && candidate.Id.GetName() == "#7") {
            @frame6 = candidate;
            break;
        }
    }

    CControlFrame@ frame7 = cast<CControlFrame>(frame6.Childs[5]);
    CControlButton@ button = cast<CControlButton>(frame7.Childs[3]);

    return button;
}

CControlGrid@ GetEditIconGrid() {


    CDx11Viewport@ viewport = cast<CDx11Viewport>(GetApp().Viewport);
    CHmsZoneOverlay@ overlay = cast<CHmsZoneOverlay>(viewport.Overlays[14]);
    CSceneSector@ sector = cast<CSceneSector>(overlay.UserData);
    CScene2d@ scene = cast<CScene2d>(sector.Scene);
    
    // Mobils 9 = CControlFrameStyled (Button 0) // Import from file
    // Mobils 13 = CGameControlCardGeneric (Button 1) // South East
    // Mobils 17 = CGameControlCardGeneric (Button 2) // North East
    // Mobils 21 = CGameControlCardGeneric (Button 3) // North West
    // Mobils 25 = CGameControlCardGeneric (Button 4) // South West

    if (scene.Mobils.Length != 55) {
        return null;
    }

    CGameMenuFrame@ frame = cast<CGameMenuFrame>(scene.Mobils[0]); // frame = FrameDialogChooseEnum
    CControlFrame@ frame1 = cast<CControlFrame>(frame.Childs[0]); // frame1 = FrameContent
    CControlFrame@ frame2 = cast<CControlFrame>(frame1.Childs[0]); // frame2 = FrameDialog
    CControlGrid@ grid = cast<CControlGrid>(frame2.Childs[2]); // grid = GridButtons

    return grid;
}