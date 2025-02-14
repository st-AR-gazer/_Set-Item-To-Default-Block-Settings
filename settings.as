[Setting hidden]
bool S_showPopupUI = true;
[Setting hidden]
bool S_showPopupUIWhenOpenplanetUIIsHidden = false;
[Setting hidden]
bool S_setItemToDefaultBlockSettingsAutomatically = false;
[Setting hidden]
bool S_useNOO = false;
[Setting hidden]
bool S_useCustomSettings = false;
[Setting hidden]
bool S_AutomaticallyAddIcon = false;

bool currentBlockHasBeenSet = false;

[SettingsTab name="General" icon="DevTo" order="1"]
void RenderSettings() {
    RT_Settings_General()
}

void RT_Settings_General() {
    UI::Text("General Settings");

    S_showPopupUI = UI::Checkbox("Show UI", S_showPopupUI);
    S_showPopupUIWhenOpenplanetUIIsHidden = UI::Checkbox("Always Show", S_showPopupUIWhenOpenplanetUIIsHidden);
    S_setItemToDefaultBlockSettingsAutomatically = UI::Checkbox("Auto Enable", S_setItemToDefaultBlockSettingsAutomatically);

    S_useNOO = UI::Checkbox("Use NOO", S_useNOO);

    S_useCustomSettings = UI::Checkbox("Custom", S_useCustomSettings);

    // FIXME: Add a file containing the directions of all the blocks at some point...
    // S_AutomaticallyAddIcon = UI::Checkbox("Icon too", S_AutomaticallyAddIcon);
    if (S_AutomaticallyAddIcon) {
        UI::Text("""
        I'd not recommend using the 'icon' option unless 'Automatic' is selected. \n
        If 'Automatic' is not selected it will just use one of the cardinal directions, \n
        without regard for if that is actually the correct direction...
        """);
    }

    UI::Separator();

    if (S_useCustomSettings) {
        UI::Text("Custom Settings");
        
        mS_SwitchPivotManually = UI::Checkbox("Switch Pivot Manually", mS_SwitchPivotManually);
        
        mS_FlyStep = UI::InputInt("Fly Step", mS_FlyStep);
        mS_FlyOffset = UI::InputInt("Fly Offset", mS_FlyOffset);
        
        mS_GridHorizontalSize = UI::InputInt("Grid Horizontal Size", mS_GridHorizontalSize);
        mS_GridHorizontalOffset = UI::InputInt("Grid Horizontal Offset", mS_GridHorizontalOffset);
        mS_GridVerticalSize = UI::InputInt("Grid Vertical Size", mS_GridVerticalSize);
        mS_GridVerticalOffset = UI::InputInt("Grid Vertical Offset", mS_GridVerticalOffset);

        mS_GhostMode = UI::Checkbox("Ghost Mode", mS_GhostMode);
        mS_YawOnly = UI::Checkbox("Yaw Only", mS_YawOnly);
        mS_NotOnObject = UI::Checkbox("Not On Object", mS_NotOnObject);
        mS_AutoRotation = UI::Checkbox("Auto Rotation", mS_AutoRotation);

        mS_PivotSnapDistance = UI::InputInt("Pivot Snap Distance", mS_PivotSnapDistance);

        UI::Separator();

        for (int i = 0; i < mS_PivotPositions.Length; i++) {
            UI::Text("Pivot Position " + (i + 1));
            mS_PivotPositions[i].x = UI::InputFloat("X##" + i, mS_PivotPositions[i].x);
            UI::SameLine();
            mS_PivotPositions[i].y = UI::InputFloat("Y##" + i, mS_PivotPositions[i].y);
            UI::SameLine();
            mS_PivotPositions[i].z = UI::InputFloat("Z##" + i, mS_PivotPositions[i].z);
        }

        UI::Separator();

        mS_IconDirection selectedDirection = mS_IconDirection::Automatic;
        string[] directionNames = {"Automatic", "Import From File", "South East", "North East", "South West", "North West"};
        int selectedIndex = int(selectedDirection);
        if (UI::BeginCombo("Icon Direction", directionNames[selectedIndex])) {
            for (int i = 0; i < directionNames.Length; i++) {
            bool isSelected = (selectedIndex == i);
            if (UI::Selectable(directionNames[i], isSelected)) {
                selectedIndex = i;
                selectedDirection = mS_IconDirection(selectedIndex);
            }
            if (isSelected) {
                UI::SetItemDefaultFocus();
            }
            }
            UI::EndCombo();
        }
    }
}

[Setting hidden]
bool mS_SwitchPivotManually = false;

[Setting hidden]
int mS_FlyStep = 8;
[Setting hidden]
int mS_FlyOffset = 0;

[Setting hidden]
int mS_GridHorizontalSize = 32;
[Setting hidden]
int mS_GridHorizontalOffset = 16;
[Setting hidden]
int mS_GridVerticalSize = 8;
[Setting hidden]
int mS_GridVerticalOffset = 0;

[Setting hidden]
bool mS_GhostMode = true;
[Setting hidden]
bool mS_YawOnly = false;
[Setting hidden]
bool mS_NotOnObject = false;
[Setting hidden]
bool mS_AutoRotation = false;

[Setting hidden]
int mS_PivotSnapDistance = 8;

[Setting hidden]
array<vec3> mS_PivotPositions = {vec3(16, 0, 16)};

[Setting hidden]
int mS_IconDirection = 0;

enum mS_IconDirection {
    SouthEast,
    NorthEast,
    SouthWest,
    NorthWest,
    ImportFromFile,
    Automatic
}
