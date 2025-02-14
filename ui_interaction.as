void SetItemSettings(CGameEditorItem@ editorItem) {
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
    editorItem.ItemModel.DefaultPlacementParam_Content.m_PivotPositions.Add(mS_PivotPositions[0]);

    // Icon Direction
    // editorItem.ItemModel.IconQuarterRotationY = ; // probably where the icon rotation is stored.
    // editorItem.ItemModel.IconUseAutoRender = ; // dictates which one we should use... (from CPlugFile or auto-generated)
    SetIconSettings(editorItem.ItemModel.IconQuarterRotationY);
}

void SetIconSettings(uint iconRotation) {
    // Find where in the UI this is set, and choose button 2/3/4/5 depending on the rotation
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