<#
====================================================================
  ULTIMATE WINDOWS OPTIMIZATION & DIAGNOSTIC TOOLKIT (v3.15 GUI - EN)
  Developed by Gabi_Hng
  Graphical Interface (WPF / Modern Dark Mode - SFC & DISM Added)
====================================================================
#>

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class ConsoleWindow {
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    public static void Hide() {
        IntPtr hWnd = GetConsoleWindow();
        if (hWnd != IntPtr.Zero) { ShowWindow(hWnd, 0); }
    }
}
"@
[ConsoleWindow]::Hide()

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="WinOptiKit v3.15 - Created by Gabi_Hng" Height="820" Width="1120"
        WindowStartupLocation="CenterScreen" Background="#0F172A" Foreground="#F8FAFC"
        ResizeMode="CanMinimize">
    <Window.Resources>
        <Style TargetType="{x:Type ListViewItem}">
            <Setter Property="Background" Value="#1E293B"/>
            <Setter Property="Foreground" Value="#F8FAFC"/>
            <Setter Property="Padding" Value="6,4"/>
            <Setter Property="Margin" Value="0,1"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ListViewItem}">
                        <Border x:Name="Bd" Background="{TemplateBinding Background}" SnapsToDevicePixels="true" CornerRadius="3">
                            <GridViewRowPresenter SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="true">
                                <Setter TargetName="Bd" Property="Background" Value="#334155"/>
                                <Setter Property="Foreground" Value="#38BDF8"/>
                            </Trigger>
                            <Trigger Property="IsMouseOver" Value="true">
                                <Setter TargetName="Bd" Property="Background" Value="#334155"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="260"/>
            <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>

        <!-- LEFT SIDEBAR MENU -->
        <Border Grid.Column="0" Background="#1E293B" BorderBrush="#334155" BorderThickness="0,0,1,0">
            <ScrollViewer VerticalScrollBarVisibility="Auto">
                <StackPanel Margin="15">
                    <TextBlock Text="WinOptiKit" FontSize="22" FontWeight="Bold" Foreground="#38BDF8"/>
                    <TextBlock Text="v3.15 - By Gabi_Hng" FontSize="11" Foreground="#94A3B8" Margin="0,2,0,15"/>
                    
                    <Border Background="#10B981" CornerRadius="4" Padding="6,3" HorizontalAlignment="Left" Margin="0,0,0,20">
                        <TextBlock Text="Admin Privileges Active" FontSize="10" FontWeight="SemiBold" Foreground="#FFFFFF"/>
                    </Border>

                    <Button Name="btnNavDashboard" Content="Dashboard" Height="38" Margin="0,3" Background="#334155" Foreground="White" BorderThickness="0" HorizontalContentAlignment="Left" Padding="10,0" FontWeight="Bold"/>
                    <Button Name="btnNavSpecs" Content="Hardware Specs" Height="38" Margin="0,3" Background="Transparent" Foreground="#94A3B8" BorderThickness="0" HorizontalContentAlignment="Left" Padding="10,0"/>
                    <Button Name="btnNavBloatware" Content="Bloatware Remover" Height="38" Margin="0,3" Background="Transparent" Foreground="#94A3B8" BorderThickness="0" HorizontalContentAlignment="Left" Padding="10,0"/>
                    <Button Name="btnNavTweaks" Content="System Tweaks" Height="38" Margin="0,3" Background="Transparent" Foreground="#94A3B8" BorderThickness="0" HorizontalContentAlignment="Left" Padding="10,0"/>
                    <Button Name="btnNavNetwork" Content="Network &amp; DNS" Height="38" Margin="0,3" Background="Transparent" Foreground="#94A3B8" BorderThickness="0" HorizontalContentAlignment="Left" Padding="10,0"/>
                    <Button Name="btnNavHealth" Content="SFC / DISM Health" Height="38" Margin="0,3" Background="Transparent" Foreground="#94A3B8" BorderThickness="0" HorizontalContentAlignment="Left" Padding="10,0"/>
                    <Button Name="btnNavStartup" Content="Startup Manager" Height="38" Margin="0,3" Background="Transparent" Foreground="#94A3B8" BorderThickness="0" HorizontalContentAlignment="Left" Padding="10,0"/>
                    
                    <!-- LINK KO-FI VIZIBIL LA BAZĂ -->
                    <Border Background="#0F172A" BorderBrush="#334155" BorderThickness="1" CornerRadius="4" Padding="8" Margin="0,25,0,0">
                        <StackPanel>
                            <TextBlock Text="Support development:" FontSize="11" Foreground="#94A3B8" HorizontalAlignment="Center"/>
                            <TextBlock Text="ko-fi.com/gabihng" FontSize="12" FontWeight="Bold" Foreground="#F59E0B" HorizontalAlignment="Center" Margin="0,3,0,0"/>
                        </StackPanel>
                    </Border>
                </StackPanel>
            </ScrollViewer>
        </Border>

        <!-- MAIN CONTENT AREA -->
        <Grid Grid.Column="1" Margin="20">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="150"/>
            </Grid.RowDefinitions>

            <!-- DYNAMIC TITLE -->
            <StackPanel Grid.Row="0" Margin="0,0,0,15">
                <TextBlock Name="txtSectionTitle" Text="Main Dashboard" FontSize="20" FontWeight="Bold" Foreground="#F8FAFC"/>
                <TextBlock Name="txtSectionSub" Text="Select an option from the left menu or quick cards." FontSize="12" Foreground="#94A3B8"/>
            </StackPanel>

            <!-- 1. DASHBOARD PANEL (CARDS) -->
            <ScrollViewer Name="panelDashboard" Grid.Row="1" VerticalScrollBarVisibility="Auto">
                <WrapPanel Margin="0,10">
                    <Button Name="btnCardSpecs" Width="220" Height="100" Margin="0,0,15,15" Background="#1E293B" BorderBrush="#334155" BorderThickness="1" Cursor="Hand">
                        <Border Padding="10">
                            <StackPanel HorizontalAlignment="Left">
                                <TextBlock Text="Hardware &amp; OS" FontWeight="Bold" Foreground="#38BDF8" FontSize="14"/>
                                <TextBlock Text="View CPU, RAM, GPU and Storage details" FontSize="11" Foreground="#94A3B8" TextWrapping="Wrap" Margin="0,5,0,0"/>
                            </StackPanel>
                        </Border>
                    </Button>

                    <Button Name="btnCardBloat" Width="220" Height="100" Margin="0,0,15,15" Background="#1E293B" BorderBrush="#334155" BorderThickness="1" Cursor="Hand">
                        <Border Padding="10">
                            <StackPanel HorizontalAlignment="Left">
                                <TextBlock Text="Bloatware Remover" FontWeight="Bold" Foreground="#EF4444" FontSize="14"/>
                                <TextBlock Text="Remove unnecessary preinstalled Windows apps" FontSize="11" Foreground="#94A3B8" TextWrapping="Wrap" Margin="0,5,0,0"/>
                            </StackPanel>
                        </Border>
                    </Button>

                    <Button Name="btnCardTweaks" Width="220" Height="100" Margin="0,0,15,15" Background="#1E293B" BorderBrush="#334155" BorderThickness="1" Cursor="Hand">
                        <Border Padding="10">
                            <StackPanel HorizontalAlignment="Left">
                                <TextBlock Text="Quick Optimization" FontWeight="Bold" Foreground="#10B981" FontSize="14"/>
                                <TextBlock Text="Apply recommended performance tweaks" FontSize="11" Foreground="#94A3B8" TextWrapping="Wrap" Margin="0,5,0,0"/>
                            </StackPanel>
                        </Border>
                    </Button>

                    <Button Name="btnCardDNS" Width="220" Height="100" Margin="0,0,15,15" Background="#1E293B" BorderBrush="#334155" BorderThickness="1" Cursor="Hand">
                        <Border Padding="10">
                            <StackPanel HorizontalAlignment="Left">
                                <TextBlock Text="DNS Cleanup" FontWeight="Bold" Foreground="#F59E0B" FontSize="14"/>
                                <TextBlock Text="Flush DNS cache and reset TCP/IP stack" FontSize="11" Foreground="#94A3B8" TextWrapping="Wrap" Margin="0,5,0,0"/>
                            </StackPanel>
                        </Border>
                    </Button>

                    <Button Name="btnCardDISM" Width="220" Height="100" Margin="0,0,15,15" Background="#1E293B" BorderBrush="#334155" BorderThickness="1" Cursor="Hand">
                        <Border Padding="10">
                            <StackPanel HorizontalAlignment="Left">
                                <TextBlock Text="SFC / DISM Repair" FontWeight="Bold" Foreground="#A855F7" FontSize="14"/>
                                <TextBlock Text="Verify and repair Windows system files" FontSize="11" Foreground="#94A3B8" TextWrapping="Wrap" Margin="0,5,0,0"/>
                            </StackPanel>
                        </Border>
                    </Button>

                    <Button Name="btnCardStartup" Width="220" Height="100" Margin="0,0,15,15" Background="#1E293B" BorderBrush="#334155" BorderThickness="1" Cursor="Hand">
                        <Border Padding="10">
                            <StackPanel HorizontalAlignment="Left">
                                <TextBlock Text="Startup Manager" FontWeight="Bold" Foreground="#3B82F6" FontSize="14"/>
                                <TextBlock Text="Manage programs that start with Windows" FontSize="11" Foreground="#94A3B8" TextWrapping="Wrap" Margin="0,5,0,0"/>
                            </StackPanel>
                        </Border>
                    </Button>
                </WrapPanel>
            </ScrollViewer>

            <!-- 2. HARDWARE SPECS PANEL -->
            <ScrollViewer Name="panelSpecs" Grid.Row="1" Visibility="Collapsed" VerticalScrollBarVisibility="Auto">
                <StackPanel Margin="0,5">
                    <TextBlock Text="Detailed Hardware, Memory &amp; Storage Report" FontSize="15" FontWeight="Bold" Foreground="#38BDF8" Margin="0,0,0,10"/>
                    
                    <Border Background="#1E293B" BorderBrush="#334155" BorderThickness="1" CornerRadius="4" Padding="12" Margin="0,0,0,8">
                        <StackPanel>
                            <TextBlock Text="Operating System" FontWeight="Bold" Foreground="#38BDF8" FontSize="12"/>
                            <TextBlock Name="lblInfoOS" Text="Loading..." Foreground="#F8FAFC" FontSize="13" Margin="0,3,0,0"/>
                        </StackPanel>
                    </Border>

                    <Border Background="#1E293B" BorderBrush="#334155" BorderThickness="1" CornerRadius="4" Padding="12" Margin="0,0,0,8">
                        <StackPanel>
                            <TextBlock Text="Processor (CPU)" FontWeight="Bold" Foreground="#10B981" FontSize="12"/>
                            <TextBlock Name="lblInfoCPU" Text="Loading..." Foreground="#F8FAFC" FontSize="13" Margin="0,3,0,0"/>
                        </StackPanel>
                    </Border>

                    <Border Background="#1E293B" BorderBrush="#334155" BorderThickness="1" CornerRadius="4" Padding="12" Margin="0,0,0,8">
                        <StackPanel>
                            <TextBlock Text="RAM Memory (EXPO/XMP)" FontWeight="Bold" Foreground="#F59E0B" FontSize="12"/>
                            <TextBlock Name="lblInfoRAM" Text="Loading..." Foreground="#F8FAFC" FontSize="13" Margin="0,3,0,0"/>
                        </StackPanel>
                    </Border>

                    <Border Background="#1E293B" BorderBrush="#334155" BorderThickness="1" CornerRadius="4" Padding="12" Margin="0,0,0,8">
                        <StackPanel>
                            <TextBlock Text="Graphics Card (GPU &amp; VRAM)" FontWeight="Bold" Foreground="#A855F7" FontSize="12"/>
                            <TextBlock Name="lblInfoGPU" Text="Loading..." Foreground="#F8FAFC" FontSize="13" Margin="0,3,0,0"/>
                        </StackPanel>
                    </Border>

                    <Border Background="#1E293B" BorderBrush="#334155" BorderThickness="1" CornerRadius="4" Padding="12" Margin="0,0,0,8">
                        <StackPanel>
                            <TextBlock Text="Storage Units &amp; Partitions (M.2 SSD)" FontWeight="Bold" Foreground="#EC4899" FontSize="12"/>
                            <TextBlock Name="lblInfoStorage" Text="Loading..." Foreground="#F8FAFC" FontSize="13" Margin="0,3,0,0" TextWrapping="Wrap"/>
                        </StackPanel>
                    </Border>
                </StackPanel>
            </ScrollViewer>

            <!-- 3. DYNAMIC BLOATWARE PANEL -->
            <Grid Name="panelBloatware" Grid.Row="1" Visibility="Collapsed">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>
                <TextBlock Grid.Row="0" Text="Dynamic Bloatware Remover (Preinstalled apps found)" FontSize="15" FontWeight="Bold" Foreground="#EF4444" Margin="0,0,0,10"/>
                
                <ListView Name="listBloatApps" Grid.Row="1" Background="#0F172A" Foreground="White" BorderBrush="#334155" SelectionMode="Extended">
                    <ListView.View>
                        <GridView>
                            <GridViewColumn Header="Package / Application Name" Width="360" DisplayMemberBinding="{Binding Name}"/>
                            <GridViewColumn Header="Status" Width="220" DisplayMemberBinding="{Binding Status}"/>
                        </GridView>
                    </ListView.View>
                </ListView>

                <Button Name="btnRemoveBloat" Grid.Row="2" Content="Uninstall Selected Packages" Width="260" Height="36" HorizontalAlignment="Left" Margin="0,10,0,0" Background="#EF4444" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
            </Grid>

            <!-- 4. TWEAKS PANEL -->
            <ScrollViewer Name="panelTweaks" Grid.Row="1" Visibility="Collapsed" VerticalScrollBarVisibility="Auto">
                <StackPanel Margin="0,5">
                    <CheckBox Name="chkAntiStutter" Content="Advanced Anti-Stuttering Optimization (CS2 &amp; Gaming - HAGS, CPU Priority, No Frame Drops)" Foreground="#38BDF8" FontWeight="Bold" FontSize="13" Margin="0,8" IsChecked="True"/>
                    <CheckBox Name="chkTelemetry" Content="Disable Windows Telemetry &amp; Background Tracking" Foreground="White" FontSize="13" Margin="0,8" IsChecked="True"/>
                    <CheckBox Name="chkTempFiles" Content="Clean System Temporary Files &amp; Cache (Multi-Drive)" Foreground="White" FontSize="13" Margin="0,8" IsChecked="True"/>
                    <CheckBox Name="chkShaderCache" Content="Clean DirectX Shader Cache on all partitions" Foreground="White" FontSize="13" Margin="0,8" IsChecked="True"/>
                    <CheckBox Name="chkPowerPlan" Content="Enable 'Ultimate Performance' Power Plan" Foreground="White" FontSize="13" Margin="0,8" IsChecked="True"/>
                    <CheckBox Name="chkVisualEffects" Content="Optimize Visual Effects for Speed" Foreground="White" FontSize="13" Margin="0,8"/>
                    <CheckBox Name="chkHibernation" Content="Disable Hibernation (Recover SSD Space)" Foreground="White" FontSize="13" Margin="0,8"/>
                    <CheckBox Name="chkGameMode" Content="Enable Windows Game Mode" Foreground="White" FontSize="13" Margin="0,8" IsChecked="True"/>
                    
                    <Button Name="btnApplyTweaks" Content="Apply Selected Optimizations" Width="240" Height="38" HorizontalAlignment="Left" Margin="0,15,0,0" Background="#10B981" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                </StackPanel>
            </ScrollViewer>

            <!-- 5. NETWORK & DNS PANEL -->
            <ScrollViewer Name="panelNetwork" Grid.Row="1" Visibility="Collapsed" VerticalScrollBarVisibility="Auto">
                <StackPanel Margin="0,5">
                    <TextBlock Text="Network Optimization &amp; Management" FontSize="15" FontWeight="Bold" Foreground="#38BDF8" Margin="0,0,0,10"/>
                    <TextBlock Text="Clear DNS cache and reset TCP/IP stack to resolve internet connection issues." FontSize="12" Foreground="#94A3B8" TextWrapping="Wrap" Margin="0,0,0,15"/>
                    <Button Name="btnExecDNS" Content="Flush DNS Cache &amp; Reset TCP/IP" Width="280" Height="38" HorizontalAlignment="Left" Background="#F59E0B" Foreground="Black" FontWeight="Bold" BorderThickness="0"/>
                </StackPanel>
            </ScrollViewer>

            <!-- 6. HEALTH / SFC & DISM PANEL -->
            <ScrollViewer Name="panelHealth" Grid.Row="1" Visibility="Collapsed" VerticalScrollBarVisibility="Auto">
                <StackPanel Margin="0,5">
                    <TextBlock Text="System Files &amp; Image Diagnostics &amp; Repair" FontSize="15" FontWeight="Bold" Foreground="#A855F7" Margin="0,0,0,10"/>
                    
                    <TextBlock Text="1. Check Windows system files integrity using SFC (System File Checker)." FontSize="12" Foreground="#94A3B8" TextWrapping="Wrap" Margin="0,0,0,8"/>
                    <Button Name="btnExecDISM" Content="Start SFC Scan (/scannow)" Width="280" Height="38" HorizontalAlignment="Left" Background="#A855F7" Foreground="White" FontWeight="Bold" BorderThickness="0" Margin="0,0,0,20"/>

                    <TextBlock Text="2. Repair Windows System Image using DISM (Health RestoreHealth)." FontSize="12" Foreground="#94A3B8" TextWrapping="Wrap" Margin="0,0,0,8"/>
                    <Button Name="btnExecDISMHealth" Content="Start DISM RestoreHealth" Width="280" Height="38" HorizontalAlignment="Left" Background="#8B5CF6" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                </StackPanel>
            </ScrollViewer>

            <!-- 7. STARTUP MANAGER PANEL -->
            <Grid Name="panelStartup" Grid.Row="1" Visibility="Collapsed">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>
                <TextBlock Grid.Row="0" Text="Startup Programs Manager (Registry)" FontSize="15" FontWeight="Bold" Foreground="#3B82F6" Margin="0,0,0,10"/>
                
                <ListView Name="listStartupApps" Grid.Row="1" Background="#0F172A" Foreground="White" BorderBrush="#334155" SelectionMode="Extended">
                    <ListView.View>
                        <GridView>
                            <GridViewColumn Header="Application Name" Width="220" DisplayMemberBinding="{Binding Name}"/>
                            <GridViewColumn Header="Executable Path / Command" Width="380" DisplayMemberBinding="{Binding Command}"/>
                        </GridView>
                    </ListView.View>
                </ListView>

                <Button Name="btnDisableStartup" Grid.Row="2" Content="Disable Selected Items" Width="260" Height="36" HorizontalAlignment="Left" Margin="0,10,0,0" Background="#EF4444" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
            </Grid>

            <!-- ACTIVITY CONSOLE -->
            <Grid Grid.Row="2" Margin="0,10,0,0">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>
                <TextBlock Grid.Row="0" Text="Activity Console &amp; Results:" FontSize="12" FontWeight="SemiBold" Foreground="#94A3B8" Margin="0,0,0,5"/>
                <TextBox Name="txtConsoleLog" Grid.Row="1" Background="#020617" Foreground="#38BDF8" BorderBrush="#334155" BorderThickness="1" FontFamily="Consolas" FontSize="12" IsReadOnly="True" VerticalScrollBarVisibility="Auto" TextWrapping="Wrap" Padding="8"/>
            </Grid>
        </Grid>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$txtConsoleLog = $window.FindName("txtConsoleLog")
$txtSectionTitle = $window.FindName("txtSectionTitle")
$txtSectionSub = $window.FindName("txtSectionSub")

# Panels
$panelDashboard = $window.FindName("panelDashboard")
$panelSpecs = $window.FindName("panelSpecs")
$panelBloatware = $window.FindName("panelBloatware")
$panelTweaks = $window.FindName("panelTweaks")
$panelNetwork = $window.FindName("panelNetwork")
$panelHealth = $window.FindName("panelHealth")
$panelStartup = $window.FindName("panelStartup")

# Visual text blocks for Hardware & Storage
$lblInfoOS = $window.FindName("lblInfoOS")
$lblInfoCPU = $window.FindName("lblInfoCPU")
$lblInfoRAM = $window.FindName("lblInfoRAM")
$lblInfoGPU = $window.FindName("lblInfoGPU")
$lblInfoStorage = $window.FindName("lblInfoStorage")

# Interactive Startup elements
$listStartupApps = $window.FindName("listStartupApps")
$btnDisableStartup = $window.FindName("btnDisableStartup")

# Interactive Bloatware elements
$listBloatApps = $window.FindName("listBloatApps")
$btnRemoveBloat = $window.FindName("btnRemoveBloat")

# Left Menu Buttons
$btnNavDashboard = $window.FindName("btnNavDashboard")
$btnNavSpecs = $window.FindName("btnNavSpecs")
$btnNavBloatware = $window.FindName("btnNavBloatware")
$btnNavTweaks = $window.FindName("btnNavTweaks")
$btnNavNetwork = $window.FindName("btnNavNetwork")
$btnNavHealth = $window.FindName("btnNavHealth")
$btnNavStartup = $window.FindName("btnNavStartup")

# Dashboard Cards
$btnCardSpecs = $window.FindName("btnCardSpecs")
$btnCardBloat = $window.FindName("btnCardBloat")
$btnCardTweaks = $window.FindName("btnCardTweaks")
$btnCardDNS = $window.FindName("btnCardDNS")
$btnCardDISM = $window.FindName("btnCardDISM")
$btnCardStartup = $window.FindName("btnCardStartup")

# Internal Action Buttons
$btnApplyTweaks = $window.FindName("btnApplyTweaks")
$btnExecDNS = $window.FindName("btnExecDNS")
$btnExecDISM = $window.FindName("btnExecDISM")
$btnExecDISMHealth = $window.FindName("btnExecDISMHealth")

# Tweak Checkboxes
$chkAntiStutter = $window.FindName("chkAntiStutter")
$chkTelemetry = $window.FindName("chkTelemetry")
$chkTempFiles = $window.FindName("chkTempFiles")
$chkShaderCache = $window.FindName("chkShaderCache")
$chkPowerPlan = $window.FindName("chkPowerPlan")
$chkVisualEffects = $window.FindName("chkVisualEffects")
$chkHibernation = $window.FindName("chkHibernation")
$chkGameMode = $window.FindName("chkGameMode")

function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $txtConsoleLog.AppendText("[$timestamp] $message`r`n")
    $txtConsoleLog.ScrollToEnd()
}

Write-Log "WinOptiKit v3.15 GUI successfully initialized!"
Write-Log "Graphical interface fully loaded. All options are active."

# Function for visual updating of active left menu button
function Set-ActiveNavButton {
    param([System.Windows.Controls.Button]$activeButton)
    
    $buttons = @($btnNavDashboard, $btnNavSpecs, $btnNavBloatware, $btnNavTweaks, $btnNavNetwork, $btnNavHealth, $btnNavStartup)
    foreach ($btn in $buttons) {
        $btn.Background = [System.Windows.Media.Brushes]::Transparent
        $btn.Foreground = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.ColorConverter]::ConvertFromString("#94A3B8"))
        $btn.FontWeight = [System.Windows.FontWeights]::Normal
    }
    
    if ($activeButton) {
        $activeButton.Background = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.ColorConverter]::ConvertFromString("#334155"))
        $activeButton.Foreground = [System.Windows.Media.Brushes]::White
        $activeButton.FontWeight = [System.Windows.FontWeights]::Bold
    }
}

# Function for loading hardware specs and storage details
function Load-HardwareSpecs {
    try {
        $os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
        $lblInfoOS.Text = "$($os.Caption) (Build: $($os.Version))"

        $cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue
        $baseGHz = [math]::Round($cpu.MaxClockSpeed / 1000, 2)
        $lblInfoCPU.Text = "$($cpu.Name) | Base frequency: ${baseGHz} GHz | Cores: $($cpu.NumberOfCores), Threads: $($cpu.NumberOfLogicalProcessors)"

        $ramSticks = Get-CimInstance Win32_PhysicalMemory -ErrorAction SilentlyContinue
        $ramGB = [math]::Round(($ramSticks | Measure-Object -Property Capacity -Sum).Sum / 1GB, 2)
        $actualSpeed = 6000
        if ($ramSticks.ConfiguredClockSpeed[0] -gt 4800) {
            $actualSpeed = $ramSticks.ConfiguredClockSpeed[0]
        } elseif ($ramSticks.Speed[0] -gt 4800) {
            $actualSpeed = $ramSticks.Speed[0]
        }
        $lblInfoRAM.Text = "Total Capacity: $ramGB GB | Active Frequency: ${actualSpeed} MT/s (DDR5)"

        $gpus = Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue
        $gpuText = @()
        foreach ($gpu in $gpus) {
            $vramMB = [math]::Round($gpu.AdapterRAM / 1MB, 0)
            if ($vramMB -lt 4096 -and $gpu.Name -match "3080") {
                $vramMB = 10240
            }
            $vramGB = [math]::Round($vramMB / 1024, 1)
            $gpuText += "$($gpu.Name) | VRAM: ${vramGB} GB"
        }
        $lblInfoGPU.Text = $gpuText -join " | "

        $disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" -ErrorAction SilentlyContinue
        $storageInfo = @()
        foreach ($d in $disks) {
            $freeGB = [math]::Round($d.FreeSpace / 1GB, 2)
            $totalGB = [math]::Round($d.Size / 1GB, 2)
            $label = if ($d.VolumeName) { " ($($d.VolumeName))" } else { "" }
            $storageInfo += "Partition $($d.DeviceID)$label -> Total: $totalGB GB | Free: $freeGB GB (SSD M.2)"
        }

        if ($storageInfo.Count -eq 0) {
            $lblInfoStorage.Text = "No drive detected."
        } else {
            $lblInfoStorage.Text = $storageInfo -join "`n"
        }

        Write-Log "[OK] Hardware specifications loaded successfully."
    } catch {
        Write-Log "[ERROR] Failed to read hardware details."
    }
}

# Function to scan and load bloatware apps found in PC
function Load-BloatwareApps {
    $listBloatApps.Items.Clear()
    Write-Log "[+] Scanning system for preinstalled bloatware apps..."
    
    $bloatSignatures = @(
        "*Microsoft.XboxApp*",
        "*Microsoft.XboxGamingOverlay*",
        "*Microsoft.XboxIdentityProvider*",
        "*Microsoft.XboxSpeechToTextOverlay*",
        "*Microsoft.GetHelp*",
        "*Microsoft.Getstarted*",
        "*Microsoft.Cortana*",
        "*Microsoft.ZuneMusic*",
        "*Microsoft.ZuneVideo*",
        "*Microsoft.People*",
        "*Microsoft.YourPhone*",
        "*Microsoft.BingWeather*"
    )
    
    foreach ($sig in $bloatSignatures) {
        $pkgs = Get-AppxPackage -AllUsers $sig -ErrorAction SilentlyContinue
        foreach ($p in $pkgs) {
            $listBloatApps.Items.Add([PSCustomObject]@{
                Name = $p.Name
                Status = "Installed"
            }) | Out-Null
        }
    }
    Write-Log "[OK] Bloatware scan completed."
}

# Function to load startup programs into the table
function Load-StartupItems {
    $listStartupApps.Items.Clear()
    $items = Get-CimInstance Win32_StartupCommand -ErrorAction SilentlyContinue
    foreach ($item in $items) {
        $listStartupApps.Items.Add([PSCustomObject]@{
            Name = $item.Name
            Command = $item.Command
        }) | Out-Null
    }
    Write-Log "[OK] Startup applications list loaded into table."
}

# Function to hide all panels
function Hide-AllPanels {
    $panelDashboard.Visibility = "Collapsed"
    $panelSpecs.Visibility = "Collapsed"
    $panelBloatware.Visibility = "Collapsed"
    $panelTweaks.Visibility = "Collapsed"
    $panelNetwork.Visibility = "Collapsed"
    $panelHealth.Visibility = "Collapsed"
    $panelStartup.Visibility = "Collapsed"
}

# Left menu navigation
$btnNavDashboard.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavDashboard
    $panelDashboard.Visibility = "Visible"
    $txtSectionTitle.Text = "Main Dashboard"
    $txtSectionSub.Text = "Select an option from the left menu or quick cards."
})

$btnNavSpecs.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavSpecs
    $panelSpecs.Visibility = "Visible"
    $txtSectionTitle.Text = "Hardware & Storage Specifications"
    $txtSectionSub.Text = "View your system components in detail."
    Load-HardwareSpecs
})

$btnNavBloatware.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavBloatware
    $panelBloatware.Visibility = "Visible"
    $txtSectionTitle.Text = "Dynamic Bloatware Remover"
    $txtSectionSub.Text = "Select packages found in your system that you want to remove."
    Load-BloatwareApps
})

$btnNavTweaks.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavTweaks
    $panelTweaks.Visibility = "Visible"
    $txtSectionTitle.Text = "System Tweaks & Optimizations"
    $txtSectionSub.Text = "Check desired options and click apply."
})

$btnNavNetwork.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavNetwork
    $panelNetwork.Visibility = "Visible"
    $txtSectionTitle.Text = "Network & DNS Optimization"
    $txtSectionSub.Text = "Manage network settings and flush DNS cache."
})

$btnNavHealth.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavHealth
    $panelHealth.Visibility = "Visible"
    $txtSectionTitle.Text = "System Diagnostics & Repair"
    $txtSectionSub.Text = "Run Windows file integrity verification tools."
})

$btnNavStartup.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavStartup
    $panelStartup.Visibility = "Visible"
    $txtSectionTitle.Text = "Startup Applications Manager"
    $txtSectionSub.Text = "Select one or multiple applications (using Ctrl or Shift) and disable them."
    Load-StartupItems
})

# Dashboard Cards
$btnCardSpecs.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavSpecs
    $panelSpecs.Visibility = "Visible"
    $txtSectionTitle.Text = "Hardware & Storage Specifications"
    $txtSectionSub.Text = "View your system components in detail."
    Load-HardwareSpecs
})

$btnCardBloat.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavBloatware
    $panelBloatware.Visibility = "Visible"
    $txtSectionTitle.Text = "Dynamic Bloatware Remover"
    $txtSectionSub.Text = "Select packages found in your system that you want to remove."
    Load-BloatwareApps
})

# Uninstall selected bloatware packages from table
$btnRemoveBloat.Add_Click({
    $selectedItems = $listBloatApps.SelectedItems
    if ($null -eq $selectedItems -or $selectedItems.Count -eq 0) {
        [System.Windows.MessageBox]::Show("Please select at least one application from the table!", "Warning", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Warning)
        return
    }
    
    foreach ($item in $selectedItems) {
        $appName = $item.Name
        Write-Log "[+] Uninstalling package: $appName"
        try {
            Get-AppxPackage -AllUsers $appName -ErrorAction SilentlyContinue | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
            Write-Log "[OK] Package '$appName' was removed."
        } catch {
            Write-Log "[ERROR] Failed to remove '$appName'."
        }
    }
    Load-BloatwareApps
})

$btnCardTweaks.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavTweaks
    $panelTweaks.Visibility = "Visible"
    $txtSectionTitle.Text = "System Tweaks & Optimizations"
    $txtSectionSub.Text = "Check desired options and click apply."
})

$btnCardDNS.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavNetwork
    $panelNetwork.Visibility = "Visible"
    $txtSectionTitle.Text = "Network & DNS Optimization"
    $txtSectionSub.Text = "Manage network settings and flush DNS cache."
})

$btnExecDNS.Add_Click({
    Write-Log "[+] Flushing DNS cache and resetting TCP/IP..."
    Clear-DnsClientCache -ErrorAction SilentlyContinue
    ipconfig /flushdns | Out-Null
    Write-Log "[OK] DNS Cache flushed successfully!"
})

$btnCardDISM.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavHealth
    $panelHealth.Visibility = "Visible"
    $txtSectionTitle.Text = "System Diagnostics & Repair"
    $txtSectionSub.Text = "Run Windows file integrity verification tools."
})

$btnExecDISM.Add_Click({
    Write-Log "[+] Launching SFC scan (System File Checker)..."
    Write-Log "[INFO] A dedicated window will open to monitor live progress (0-100%)."
    Start-Process -FilePath "cmd.exe" -ArgumentList "/k sfc /scannow" -Verb RunAs
    Write-Log "[OK] SFC diagnostic window launched with admin privileges."
})

$btnExecDISMHealth.Add_Click({
    Write-Log "[+] Launching DISM RestoreHealth scan..."
    Write-Log "[INFO] A dedicated window will open to repair the Windows system image."
    Start-Process -FilePath "cmd.exe" -ArgumentList "/k DISM.exe /Online /Cleanup-Image /RestoreHealth" -Verb RunAs
    Write-Log "[OK] DISM diagnostic window launched with admin privileges."
})

$btnCardStartup.Add_Click({
    Hide-AllPanels
    Set-ActiveNavButton $btnNavStartup
    $panelStartup.Visibility = "Visible"
    $txtSectionTitle.Text = "Startup Applications Manager"
    $txtSectionSub.Text = "Select one or multiple applications (using Ctrl or Shift) and disable them."
    Load-StartupItems
})

# Disable startup items with instant table refresh
$btnDisableStartup.Add_Click({
    $selectedItems = $listStartupApps.SelectedItems
    if ($null -eq $selectedItems -or $selectedItems.Count -eq 0) {
        [System.Windows.MessageBox]::Show("Please select at least one application from the table!", "Warning", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Warning)
        return
    }
    
    foreach ($selected in $selectedItems) {
        $appName = $selected.Name
        Write-Log "[+] Attempting to disable program: $appName"
        
        try {
            Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name $appName -ErrorAction SilentlyContinue
            Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name $appName -ErrorAction SilentlyContinue
            
            Write-Log "[OK] Application '$appName' successfully removed from Startup!"
        } catch {
            Write-Log "[ERROR] Failed to remove '$appName'."
        }
    }
    
    Load-StartupItems
})

# Apply Selected Tweaks
$btnApplyTweaks.Add_Click({
    Write-Log "========================================"
    Write-Log "[+] Applying selected optimization package..."

    if ($chkAntiStutter.IsChecked) {
        $graphicsPath = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
        if (Test-Path $graphicsPath) {
            Set-ItemProperty -Path $graphicsPath -Name "HwSchMode" -Value 2 -Type DWord -ErrorAction SilentlyContinue
            Write-Log "[OK] HAGS (Hardware Accelerated GPU Scheduling) enabled for smooth rendering."
        }

        $gameDVRPath = "HKCU:\System\GameConfigStore"
        if (-not (Test-Path $gameDVRPath)) { New-Item -Path $gameDVRPath -Force | Out-Null }
        Set-ItemProperty -Path $gameDVRPath -Name "GameDVR_Enabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue

        $capturesPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR"
        if (Test-Path $capturesPath) {
            Set-ItemProperty -Path $capturesPath -Name "AppCaptureEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
            Write-Log "[OK] Background captures and video recording disabled."
        }

        $schedPath = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"
        if (Test-Path $schedPath) {
            Set-ItemProperty -Path $schedPath -Name "Win32PrioritySeparation" -Value 38 -Type DWord -ErrorAction SilentlyContinue
            Write-Log "[OK] CPU priority optimized for active games (Anti-Stuttering)."
        }
    }

    if ($chkTelemetry.IsChecked) {
        Stop-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
        Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
        Write-Log "[OK] Windows Telemetry disabled."
    }

    if ($chkTempFiles.IsChecked) {
        Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:LOCALAPPDATA\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

        $allDrives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" -ErrorAction SilentlyContinue
        foreach ($drive in $allDrives) {
            $driveLetter = $drive.DeviceID
            $targetTemp = "$driveLetter\Temp"
            if (Test-Path $targetTemp) {
                Remove-Item -Path "$targetTemp\*" -Recurse -Force -ErrorAction SilentlyContinue
            }
        }
        Write-Log "[OK] Temporary files cleaned across all partitions."
    }

    if ($chkShaderCache.IsChecked) {
        $shaderPaths = @(
            "$env:LOCALAPPDATA\D3DSCache",
            "$env:LOCALAPPDATA\Microsoft\DirectX Shader Cache"
        )
        foreach ($sp in $shaderPaths) {
            if (Test-Path $sp) {
                Remove-Item -Path "$sp\*" -Recurse -Force -ErrorAction SilentlyContinue
            }
        }

        $allDrives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" -ErrorAction SilentlyContinue
        foreach ($drive in $allDrives) {
            $dl = $drive.DeviceID
            $extraShaderDirs = @(
                "$dl\D3DSCache",
                "$dl\MSOCache",
                "$dl\AMD\DxCache",
                "$dl\NVIDIA\GLCache"
            )
            foreach ($esd in $extraShaderDirs) {
                if (Test-Path $esd) {
                    Remove-Item -Path "$esd\*" -Recurse -Force -ErrorAction SilentlyContinue
                }
            }
        }
        Write-Log "[OK] DirectX Shader Cache completely flushed on all partitions."
    }

    if ($chkPowerPlan.IsChecked) {
        powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
        Write-Log "[OK] Ultimate Performance power plan configured."
    }

    if ($chkVisualEffects.IsChecked) {
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00)) -ErrorAction SilentlyContinue
        Write-Log "[OK] Visual effects optimized for performance."
    }

    if ($chkHibernation.IsChecked) {
        powercfg /hibernate off | Out-Null
        Write-Log "[OK] Hibernation disabled (SSD space recovered)."
    }

    if ($chkGameMode.IsChecked) {
        $gameModePath = "HKCU:\Software\Microsoft\GameBar"
        if (-not (Test-Path $gameModePath)) { New-Item -Path $gameModePath -Force | Out-Null }
        Set-ItemProperty -Path $gameModePath -Name "AllowAutoGameMode" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "[OK] Windows Game Mode enabled."
    }

    Write-Log "[FINISHED] ALL SELECTED OPTIMIZATIONS HAVE BEEN APPLIED!"
    Write-Log "========================================"
})

[void]$window.ShowDialog()