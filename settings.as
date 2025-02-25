[Setting hidden]
bool S_showPopupUI = true;
[Setting hidden]
bool S_showPopupUIWhenOpenplanetUIIsHidden = false;
[Setting hidden]
bool S_setItemToDefaultBlockSettingsAutomatically = false;
// [Setting hidden]
// bool S_useNOO = false;
[Setting hidden]
bool S_useCustomSettings = false;
[Setting hidden]
bool S_AutomaticallyAddIcon = false;

[SettingsTab name="General" icon="Cog" order="1"]
void RenderSettings() {
    RT_Settings_General();
}

void RT_Settings_General() {
    UI::Text("General Settings");

    S_showPopupUI = UI::Checkbox("Show UI", S_showPopupUI);
    S_showPopupUIWhenOpenplanetUIIsHidden = UI::Checkbox("Always Show", S_showPopupUIWhenOpenplanetUIIsHidden);
    S_setItemToDefaultBlockSettingsAutomatically = UI::Checkbox("Auto Enable", S_setItemToDefaultBlockSettingsAutomatically);

    mS_NotOnObject = UI::Checkbox("Use NOO", mS_NotOnObject);

    // FIXME: Add a file containing the directions of all the blocks at some point...
    // S_AutomaticallyAddIcon = UI::Checkbox("Icon too", S_AutomaticallyAddIcon);
    if (S_AutomaticallyAddIcon) {
        UI::Text("""
        I'd not recommend using the 'icon' option unless 'Automatic' is selected. \n
        If 'Automatic' is not selected it will just use one of the cardinal directions, \n
        without regard for if that is actually the correct direction...
        """);
    }

    S_useCustomSettings = UI::Checkbox("Custom", S_useCustomSettings);
    UI::Separator();

    if (S_useCustomSettings) {
        UI::Text("Custom Settings");
        
        mS_SwitchPivotManually = UI::Checkbox("Switch Pivot Manually", mS_SwitchPivotManually);
        
        UI::PushItemWidth(150); mS_FlyStep = UI::InputInt("Fly Step", mS_FlyStep); UI::PopItemWidth();
        UI::PushItemWidth(150); mS_FlyOffset = UI::InputInt("Fly Offset", mS_FlyOffset); UI::PopItemWidth();
        

        UI::PushItemWidth(150); mS_GridHorizontalSize = UI::InputInt("Grid Horizontal Size", mS_GridHorizontalSize); UI::PopItemWidth();
        UI::PushItemWidth(150); mS_GridHorizontalOffset = UI::InputInt("Grid Horizontal Offset", mS_GridHorizontalOffset); UI::PopItemWidth();
        UI::PushItemWidth(150); mS_GridVerticalSize = UI::InputInt("Grid Vertical Size", mS_GridVerticalSize); UI::PopItemWidth();
        UI::PushItemWidth(150); mS_GridVerticalOffset = UI::InputInt("Grid Vertical Offset", mS_GridVerticalOffset); UI::PopItemWidth();

        mS_GhostMode = UI::Checkbox("Ghost Mode", mS_GhostMode);
        mS_YawOnly = UI::Checkbox("Yaw Only", mS_YawOnly);
        mS_NotOnObject = UI::Checkbox("Not On Object", mS_NotOnObject);
        mS_AutoRotation = UI::Checkbox("Auto Rotation", mS_AutoRotation);

        UI::PushItemWidth(150); mS_PivotSnapDistance = UI::InputInt("Pivot Snap Distance", mS_PivotSnapDistance); UI::PopItemWidth();

        UI::Separator();

        UI::Text("Pivot Positions");
        UI::PushItemWidth(120); mS_PivotPositions_X = UI::InputInt("X", mS_PivotPositions_X); UI::PopItemWidth();
        UI::SameLine();
        UI::PushItemWidth(120); mS_PivotPositions_Y = UI::InputInt("Y", mS_PivotPositions_Y); UI::PopItemWidth();
        UI::SameLine();
        UI::PushItemWidth(120); mS_PivotPositions_Z = UI::InputInt("Z", mS_PivotPositions_Z); UI::PopItemWidth();

        UI::Separator();

        UI::PushItemWidth(200);
        string[] directionNames = {"South East", "North East", "South West", "North West", "Import From File", "Automatic"};
        int selectedIndex = int(selectedDirection);
        if (UI::BeginCombo("Icon Direction", directionNames[selectedIndex])) {
            for (int i = 0; i < int(directionNames.Length); i++) {
                bool isSelected = (selectedIndex == i);
                if (UI::Selectable(directionNames[i], isSelected)) {
                    selectedIndex = i;
                    selectedDirection = mS_enumIconDirection(selectedIndex);
                }
                if (isSelected) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }
        UI::PopItemWidth();
        if (selectedDirection != mS_enumIconDirection::Automatic) {
            UI::Text("\\$aaa" + "Stronly recommend using 'Automatic' for this setting.");
        }
        
        UI::Separator();
    }
    


    if (S_showWindowPosSettings) {
        // Display header with a clickable chevron down to close the window.
        UI::Text("Window Position " + Icons::ChevronCircleDown);
        if (UI::IsItemClicked(UI::MouseButton::Left)) {
            S_showWindowPosSettings = false;
        }

        UI::Text("Current Position: " + UI::GetWindowPos().x + ", " + UI::GetWindowPos().y);
        UI::Text("Collapsed position:");
        if (UI::Button("Set Screen Position (col)")) { UI::SetWindowPos(collapsedPopupUIPos); }
        UI::PushItemWidth(150); collapsedPopupUIPos.x = UI::InputInt("col X", int(collapsedPopupUIPos.x)); UI::PopItemWidth();
        UI::SameLine();
        UI::PushItemWidth(150); collapsedPopupUIPos.y = UI::InputInt("col Y", int(collapsedPopupUIPos.y)); UI::PopItemWidth();
        UI::Text("Expanded position:");
        if (UI::Button("Set Screen Position (exp)")) { UI::SetWindowPos(expandedPopupUIPos); }
        UI::PushItemWidth(150); expandedPopupUIPos.x = UI::InputInt("exp X", int(expandedPopupUIPos.x)); UI::PopItemWidth();
        UI::SameLine();
        UI::PushItemWidth(150); expandedPopupUIPos.y = UI::InputInt("exp Y", int(expandedPopupUIPos.y)); UI::PopItemWidth();
    } else {
        // Display header with a clickable chevron right to open the window.
        UI::Text("Window Position " + Icons::ChevronCircleRight);
        if (UI::IsItemClicked(UI::MouseButton::Left)) {
            S_showWindowPosSettings = true;
        }
    }
}

[Setting hidden]
bool S_showWindowPosSettings = false;

[Setting hidden]
mS_enumIconDirection selectedDirection = mS_enumIconDirection::Automatic;

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
bool mS_NotOnObject = true;
[Setting hidden]
bool mS_AutoRotation = false;

[Setting hidden]
int mS_PivotSnapDistance = -1;

[Setting hidden]
int mS_PivotPositions_X = 16;
[Setting hidden]
int mS_PivotPositions_Y = 0;
[Setting hidden]
int mS_PivotPositions_Z = 16;


[Setting hidden]
int mS_IconDirection = 0;

enum mS_enumIconDirection {
    SouthEast,
    NorthEast,
    SouthWest,
    NorthWest,
    ImportFromFile,
    Automatic
}
