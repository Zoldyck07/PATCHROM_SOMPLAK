.class Lcom/android/server/ServerThread;
.super Ljava/lang/Object;
.source "SystemServer.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/ServerThread$PerformanceProfileObserver;,
        Lcom/android/server/ServerThread$AdbPortObserver;
    }
.end annotation


# static fields
.field private static final ENCRYPTED_STATE:Ljava/lang/String; = "1"

.field private static final ENCRYPTING_STATE:Ljava/lang/String; = "trigger_restart_min_framework"

.field private static final TAG:Ljava/lang/String; = "SystemServer"


# instance fields
.field mContentResolver:Landroid/content/ContentResolver;


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 99
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 124
    return-void
.end method

.method private static final deviceHasSufficientMemory()Z
    .locals 7

    .prologue
    .line 1322
    const-wide/32 v0, 0x20000000

    .line 1324
    .local v0, MEMORY_SIZE_MIN:J
    new-instance v2, Lcom/android/internal/util/MemInfoReader;

    invoke-direct {v2}, Lcom/android/internal/util/MemInfoReader;-><init>()V

    .line 1325
    .local v2, minfo:Lcom/android/internal/util/MemInfoReader;
    invoke-virtual {v2}, Lcom/android/internal/util/MemInfoReader;->readMemInfo()V

    .line 1326
    invoke-virtual {v2}, Lcom/android/internal/util/MemInfoReader;->getTotalSize()J

    move-result-wide v3

    const-wide/32 v5, 0x20000000

    cmp-long v3, v3, v5

    if-gtz v3, :cond_0

    .line 1327
    const/4 v3, 0x0

    .line 1329
    :goto_0
    return v3

    :cond_0
    const/4 v3, 0x1

    goto :goto_0
.end method

.method static final startSystemUi(Landroid/content/Context;)V
    .locals 4
    .parameter "context"

    .prologue
    .line 1314
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 1315
    .local v0, intent:Landroid/content/Intent;
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.android.systemui"

    const-string v3, "com.android.systemui.SystemUIService"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 1318
    sget-object v1, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->startServiceAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)Landroid/content/ComponentName;

    .line 1319
    return-void
.end method


# virtual methods
.method public initAndLoop()V
    .locals 182

    .prologue
    .line 151
    const/16 v7, 0xbc2

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v9

    invoke-static {v7, v9, v10}, Landroid/util/EventLog;->writeEvent(IJ)I

    .line 154
    invoke-static {}, Landroid/os/Looper;->prepareMainLooper()V

    .line 156
    const/4 v7, -0x2

    invoke-static {v7}, Landroid/os/Process;->setThreadPriority(I)V

    .line 159
    const/4 v7, 0x1

    invoke-static {v7}, Lcom/android/internal/os/BinderInternal;->disableBackgroundScheduling(Z)V

    .line 160
    const/4 v7, 0x0

    invoke-static {v7}, Landroid/os/Process;->setCanSelfBackground(Z)V

    .line 164
    const-string v7, "sys.shutdown.requested"

    const-string v9, ""

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v156

    .line 166
    .local v156, shutdownAction:Ljava/lang/String;
    if-eqz v156, :cond_0

    invoke-virtual/range {v156 .. v156}, Ljava/lang/String;->length()I

    move-result v7

    if-lez v7, :cond_0

    .line 167
    const/4 v7, 0x0

    move-object/from16 v0, v156

    invoke-virtual {v0, v7}, Ljava/lang/String;->charAt(I)C

    move-result v7

    const/16 v9, 0x31

    if-ne v7, v9, :cond_29

    const/16 v148, 0x1

    .line 170
    .local v148, reboot:Z
    :goto_0
    invoke-virtual/range {v156 .. v156}, Ljava/lang/String;->length()I

    move-result v7

    const/4 v9, 0x1

    if-le v7, v9, :cond_2a

    .line 171
    const/4 v7, 0x1

    invoke-virtual/range {v156 .. v156}, Ljava/lang/String;->length()I

    move-result v9

    move-object/from16 v0, v156

    invoke-virtual {v0, v7, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v147

    .line 176
    .local v147, reason:Ljava/lang/String;
    :goto_1
    move/from16 v0, v148

    move-object/from16 v1, v147

    invoke-static {v0, v1}, Lcom/android/server/power/ShutdownThread;->rebootOrShutdown(ZLjava/lang/String;)V

    .line 180
    .end local v147           #reason:Ljava/lang/String;
    .end local v148           #reboot:Z
    :cond_0
    const-string v7, "ro.factorytest"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v107

    .line 181
    .local v107, factoryTestStr:Ljava/lang/String;
    const-string v7, ""

    move-object/from16 v0, v107

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2b

    const/16 v106, 0x0

    .line 183
    .local v106, factoryTest:I
    :goto_2
    const-string v7, "1"

    const-string v9, "ro.config.headless"

    const-string v10, "0"

    invoke-static {v9, v10}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v33

    .line 185
    .local v33, headless:Z
    const/16 v116, 0x0

    .line 186
    .local v116, installer:Lcom/android/server/pm/Installer;
    const/16 v65, 0x0

    .line 187
    .local v65, accountManager:Lcom/android/server/accounts/AccountManagerService;
    const/16 v83, 0x0

    .line 188
    .local v83, contentService:Lcom/android/server/content/ContentService;
    const/16 v118, 0x0

    .line 189
    .local v118, lights:Lcom/android/server/LightsService;
    const/4 v4, 0x0

    .line 190
    .local v4, power:Lcom/android/server/power/PowerManagerService;
    const/16 v97, 0x0

    .line 191
    .local v97, display:Lcom/android/server/display/DisplayManagerService;
    const/16 v72, 0x0

    .line 192
    .local v72, battery:Lcom/android/server/BatteryService;
    const/16 v171, 0x0

    .line 193
    .local v171, vibrator:Lcom/android/server/VibratorService;
    const/16 v67, 0x0

    .line 194
    .local v67, alarm:Lcom/android/server/AlarmManagerService;
    const/16 v126, 0x0

    .line 195
    .local v126, mountService:Lcom/android/server/MountService;
    const/16 v30, 0x0

    .line 196
    .local v30, networkManagement:Lcom/android/server/NetworkManagementService;
    const/16 v29, 0x0

    .line 197
    .local v29, networkStats:Lcom/android/server/net/NetworkStatsService;
    const/16 v130, 0x0

    .line 198
    .local v130, networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    const/16 v79, 0x0

    .line 199
    .local v79, connectivity:Lcom/android/server/ConnectivityService;
    const/16 v143, 0x0

    .line 200
    .local v143, qcCon:Ljava/lang/Object;
    const/16 v178, 0x0

    .line 201
    .local v178, wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    const/16 v176, 0x0

    .line 202
    .local v176, wifi:Lcom/android/server/wifi/WifiService;
    const/16 v155, 0x0

    .line 203
    .local v155, serviceDiscovery:Lcom/android/server/NsdService;
    const/16 v137, 0x0

    .line 204
    .local v137, pm:Landroid/content/pm/IPackageManager;
    const/4 v5, 0x0

    .line 205
    .local v5, context:Landroid/content/Context;
    const/16 v180, 0x0

    .line 206
    .local v180, wm:Lcom/android/server/wm/WindowManagerService;
    const/16 v73, 0x0

    .line 207
    .local v73, bluetooth:Lcom/android/server/BluetoothManagerService;
    const/16 v98, 0x0

    .line 208
    .local v98, dock:Lcom/android/server/DockObserver;
    const/16 v151, 0x0

    .line 209
    .local v151, rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    const/16 v169, 0x0

    .line 210
    .local v169, usb:Lcom/android/server/usb/UsbService;
    const/16 v153, 0x0

    .line 211
    .local v153, serial:Lcom/android/server/SerialService;
    const/16 v165, 0x0

    .line 212
    .local v165, twilight:Lcom/android/server/TwilightService;
    const/16 v167, 0x0

    .line 213
    .local v167, uiMode:Lcom/android/server/UiModeManagerService;
    const/16 v149, 0x0

    .line 214
    .local v149, recognition:Lcom/android/server/RecognitionManagerService;
    const/16 v132, 0x0

    .line 215
    .local v132, networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    const/16 v76, 0x0

    .line 216
    .local v76, commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    const/16 v115, 0x0

    .line 217
    .local v115, inputManager:Lcom/android/server/input/InputManagerService;
    const/16 v159, 0x0

    .line 218
    .local v159, telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    const/16 v128, 0x0

    .line 219
    .local v128, msimTelephonyRegistry:Lcom/android/server/MSimTelephonyRegistry;
    const/16 v81, 0x0

    .line 222
    .local v81, consumerIr:Lcom/android/server/ConsumerIrService;
    new-instance v181, Landroid/os/HandlerThread;

    const-string v7, "WindowManager"

    move-object/from16 v0, v181

    invoke-direct {v0, v7}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    .line 223
    .local v181, wmHandlerThread:Landroid/os/HandlerThread;
    invoke-virtual/range {v181 .. v181}, Landroid/os/HandlerThread;->start()V

    .line 224
    new-instance v21, Landroid/os/Handler;

    invoke-virtual/range {v181 .. v181}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v7

    move-object/from16 v0, v21

    invoke-direct {v0, v7}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 225
    .local v21, wmHandler:Landroid/os/Handler;
    new-instance v7, Lcom/android/server/ServerThread$1;

    move-object/from16 v0, p0

    invoke-direct {v7, v0}, Lcom/android/server/ServerThread$1;-><init>(Lcom/android/server/ServerThread;)V

    move-object/from16 v0, v21

    invoke-virtual {v0, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 242
    const/16 v24, 0x0

    .line 243
    .local v24, onlyCore:Z
    const/16 v109, 0x0

    .line 248
    .local v109, firstBoot:Z
    :try_start_0
    const-string v7, "SystemServer"

    const-string v9, "Waiting for installd to be ready."

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 249
    new-instance v117, Lcom/android/server/pm/Installer;

    invoke-direct/range {v117 .. v117}, Lcom/android/server/pm/Installer;-><init>()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 250
    .end local v116           #installer:Lcom/android/server/pm/Installer;
    .local v117, installer:Lcom/android/server/pm/Installer;
    :try_start_1
    invoke-virtual/range {v117 .. v117}, Lcom/android/server/pm/Installer;->ping()Z

    .line 252
    const-string v7, "SystemServer"

    const-string v9, "Power Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 253
    new-instance v138, Lcom/android/server/power/PowerManagerService;

    invoke-direct/range {v138 .. v138}, Lcom/android/server/power/PowerManagerService;-><init>()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_6a

    .line 254
    .end local v4           #power:Lcom/android/server/power/PowerManagerService;
    .local v138, power:Lcom/android/server/power/PowerManagerService;
    :try_start_2
    const-string v7, "power"

    move-object/from16 v0, v138

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 256
    const-string v7, "SystemServer"

    const-string v9, "Activity Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 257
    invoke-static/range {v106 .. v106}, Lcom/android/server/am/ActivityManagerService;->main(I)Landroid/content/Context;
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_6b

    move-result-object v5

    move-object/from16 v4, v138

    .end local v138           #power:Lcom/android/server/power/PowerManagerService;
    .restart local v4       #power:Lcom/android/server/power/PowerManagerService;
    move-object/from16 v116, v117

    .line 263
    .end local v117           #installer:Lcom/android/server/pm/Installer;
    .restart local v116       #installer:Lcom/android/server/pm/Installer;
    :goto_3
    const-string v7, "config.disable_storage"

    const/4 v9, 0x0

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v94

    .line 264
    .local v94, disableStorage:Z
    const-string v7, "config.disable_media"

    const/4 v9, 0x0

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v91

    .line 265
    .local v91, disableMedia:Z
    const-string v7, "config.disable_bluetooth"

    const/4 v9, 0x0

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v89

    .line 266
    .local v89, disableBluetooth:Z
    const-string v7, "config.disable_telephony"

    const/4 v9, 0x0

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v96

    .line 267
    .local v96, disableTelephony:Z
    const-string v7, "config.disable_location"

    const/4 v9, 0x0

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v90

    .line 268
    .local v90, disableLocation:Z
    const-string v7, "config.disable_systemui"

    const/4 v9, 0x0

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v95

    .line 269
    .local v95, disableSystemUI:Z
    const-string v7, "config.disable_noncore"

    const/4 v9, 0x0

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v93

    .line 270
    .local v93, disableNonCoreServices:Z
    const-string v7, "config.disable_network"

    const/4 v9, 0x0

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v92

    .line 273
    .local v92, disableNetwork:Z
    :try_start_3
    const-string v7, "SystemServer"

    const-string v9, "Display Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 274
    new-instance v11, Lcom/android/server/display/DisplayManagerService;

    move-object/from16 v0, v21

    invoke-direct {v11, v5, v0}, Lcom/android/server/display/DisplayManagerService;-><init>(Landroid/content/Context;Landroid/os/Handler;)V
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_5f

    .line 275
    .end local v97           #display:Lcom/android/server/display/DisplayManagerService;
    .local v11, display:Lcom/android/server/display/DisplayManagerService;
    :try_start_4
    const-string v7, "display"

    const/4 v9, 0x1

    invoke-static {v7, v11, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;Z)V

    .line 277
    const-string v7, "SystemServer"

    const-string v9, "Telephony Registry"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 278
    new-instance v160, Lcom/android/server/TelephonyRegistry;

    move-object/from16 v0, v160

    invoke-direct {v0, v5}, Lcom/android/server/TelephonyRegistry;-><init>(Landroid/content/Context;)V
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_60

    .line 279
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .local v160, telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :try_start_5
    const-string v7, "telephony.registry"

    move-object/from16 v0, v160

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 281
    invoke-static {}, Landroid/telephony/MSimTelephonyManager;->getDefault()Landroid/telephony/MSimTelephonyManager;

    move-result-object v7

    invoke-virtual {v7}, Landroid/telephony/MSimTelephonyManager;->isMultiSimEnabled()Z

    move-result v7

    if-eqz v7, :cond_1

    .line 282
    const-string v7, "SystemServer"

    const-string v9, "MSimTelephony Registry"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 283
    new-instance v129, Lcom/android/server/MSimTelephonyRegistry;

    move-object/from16 v0, v129

    invoke-direct {v0, v5}, Lcom/android/server/MSimTelephonyRegistry;-><init>(Landroid/content/Context;)V
    :try_end_5
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_2

    .line 284
    .end local v128           #msimTelephonyRegistry:Lcom/android/server/MSimTelephonyRegistry;
    .local v129, msimTelephonyRegistry:Lcom/android/server/MSimTelephonyRegistry;
    :try_start_6
    const-string v7, "telephony.msim.registry"

    move-object/from16 v0, v129

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_6
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_61

    move-object/from16 v128, v129

    .line 287
    .end local v129           #msimTelephonyRegistry:Lcom/android/server/MSimTelephonyRegistry;
    .restart local v128       #msimTelephonyRegistry:Lcom/android/server/MSimTelephonyRegistry;
    :cond_1
    :try_start_7
    const-string v7, "SystemServer"

    const-string v9, "Scheduling Policy"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 288
    const-string v7, "scheduling_policy"

    new-instance v9, Lcom/android/server/os/SchedulingPolicyService;

    invoke-direct {v9}, Lcom/android/server/os/SchedulingPolicyService;-><init>()V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 290
    invoke-static {v5}, Lcom/android/server/AttributeCache;->init(Landroid/content/Context;)V

    .line 292
    invoke-virtual {v11}, Lcom/android/server/display/DisplayManagerService;->waitForDefaultDisplay()Z

    move-result v7

    if-nez v7, :cond_2

    .line 293
    const-string v7, "Timeout waiting for default display to be initialized."

    new-instance v9, Ljava/lang/Throwable;

    invoke-direct {v9}, Ljava/lang/Throwable;-><init>()V

    move-object/from16 v0, p0

    invoke-virtual {v0, v7, v9}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 297
    :cond_2
    const-string v7, "SystemServer"

    const-string v9, "Package Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 299
    const-string v7, "vold.decrypt"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v86

    .line 300
    .local v86, cryptState:Ljava/lang/String;
    const-string v7, "trigger_restart_min_framework"

    move-object/from16 v0, v86

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2c

    .line 301
    const-string v7, "SystemServer"

    const-string v9, "Detected encryption in progress - only parsing core apps"

    invoke-static {v7, v9}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 302
    const/16 v24, 0x1

    .line 308
    :cond_3
    :goto_4
    if-eqz v106, :cond_2d

    const/4 v7, 0x1

    :goto_5
    move-object/from16 v0, v116

    move/from16 v1, v24

    invoke-static {v5, v0, v7, v1}, Lcom/android/server/pm/PackageManagerService;->main(Landroid/content/Context;Lcom/android/server/pm/Installer;ZZ)Landroid/content/pm/IPackageManager;
    :try_end_7
    .catch Ljava/lang/RuntimeException; {:try_start_7 .. :try_end_7} :catch_2

    move-result-object v137

    .line 312
    :try_start_8
    invoke-interface/range {v137 .. v137}, Landroid/content/pm/IPackageManager;->isFirstBoot()Z
    :try_end_8
    .catch Landroid/os/RemoteException; {:try_start_8 .. :try_end_8} :catch_43
    .catch Ljava/lang/RuntimeException; {:try_start_8 .. :try_end_8} :catch_2

    move-result v109

    .line 316
    :goto_6
    :try_start_9
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->setSystemProcess()V

    .line 318
    const-string v7, "SystemServer"

    const-string v9, "Entropy Mixer"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 319
    const-string v7, "entropy"

    new-instance v9, Lcom/android/server/EntropyMixer;

    invoke-direct {v9, v5}, Lcom/android/server/EntropyMixer;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 321
    const-string v7, "SystemServer"

    const-string v9, "User Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 322
    const-string v7, "user"

    invoke-static {}, Lcom/android/server/pm/UserManagerService;->getInstance()Lcom/android/server/pm/UserManagerService;

    move-result-object v9

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 325
    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    move-object/from16 v0, p0

    iput-object v7, v0, Lcom/android/server/ServerThread;->mContentResolver:Landroid/content/ContentResolver;
    :try_end_9
    .catch Ljava/lang/RuntimeException; {:try_start_9 .. :try_end_9} :catch_2

    .line 330
    :try_start_a
    const-string v7, "SystemServer"

    const-string v9, "Account Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 331
    new-instance v66, Lcom/android/server/accounts/AccountManagerService;

    move-object/from16 v0, v66

    invoke-direct {v0, v5}, Lcom/android/server/accounts/AccountManagerService;-><init>(Landroid/content/Context;)V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_a .. :try_end_a} :catch_2

    .line 332
    .end local v65           #accountManager:Lcom/android/server/accounts/AccountManagerService;
    .local v66, accountManager:Lcom/android/server/accounts/AccountManagerService;
    :try_start_b
    const-string v7, "account"

    move-object/from16 v0, v66

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_69
    .catch Ljava/lang/RuntimeException; {:try_start_b .. :try_end_b} :catch_62

    move-object/from16 v65, v66

    .line 337
    .end local v66           #accountManager:Lcom/android/server/accounts/AccountManagerService;
    .restart local v65       #accountManager:Lcom/android/server/accounts/AccountManagerService;
    :goto_7
    :try_start_c
    const-string v7, "SystemServer"

    const-string v9, "Content Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 338
    const/4 v7, 0x1

    move/from16 v0, v106

    if-ne v0, v7, :cond_2e

    const/4 v7, 0x1

    :goto_8
    invoke-static {v5, v7}, Lcom/android/server/content/ContentService;->main(Landroid/content/Context;Z)Lcom/android/server/content/ContentService;

    move-result-object v83

    .line 341
    const-string v7, "SystemServer"

    const-string v9, "System Content Providers"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 342
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->installSystemProviders()V

    .line 344
    const-string v7, "SystemServer"

    const-string v9, "Lights Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

<<<<<<< HEAD
    .line 345
    new-instance v6, Lcom/android/server/LightsService;
=======
    .line 319
    new-instance v6, Lcom/android/server/MiuiLightsService;
>>>>>>> 16498b4... resolve the conflicts

    invoke-direct {v6, v5}, Lcom/android/server/MiuiLightsService;-><init>(Landroid/content/Context;)V
    :try_end_c
    .catch Ljava/lang/RuntimeException; {:try_start_c .. :try_end_c} :catch_2

    .line 347
    .end local v118           #lights:Lcom/android/server/LightsService;
    .local v6, lights:Lcom/android/server/LightsService;
    :try_start_d
    const-string v7, "SystemServer"

    const-string v9, "Battery Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 348
    new-instance v8, Lcom/android/server/BatteryService;

    invoke-direct {v8, v5, v6}, Lcom/android/server/BatteryService;-><init>(Landroid/content/Context;Lcom/android/server/LightsService;)V
    :try_end_d
    .catch Ljava/lang/RuntimeException; {:try_start_d .. :try_end_d} :catch_63

    .line 349
    .end local v72           #battery:Lcom/android/server/BatteryService;
    .local v8, battery:Lcom/android/server/BatteryService;
    :try_start_e
    const-string v7, "battery"

    invoke-static {v7, v8}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 351
    const-string v7, "SystemServer"

    const-string v9, "Vibrator Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 352
    new-instance v172, Lcom/android/server/VibratorService;

    move-object/from16 v0, v172

    invoke-direct {v0, v5}, Lcom/android/server/VibratorService;-><init>(Landroid/content/Context;)V
    :try_end_e
    .catch Ljava/lang/RuntimeException; {:try_start_e .. :try_end_e} :catch_64

    .line 353
    .end local v171           #vibrator:Lcom/android/server/VibratorService;
    .local v172, vibrator:Lcom/android/server/VibratorService;
    :try_start_f
    const-string v7, "vibrator"

    move-object/from16 v0, v172

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 355
    const-string v7, "SystemServer"

    const-string v9, "Consumer IR Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 356
    new-instance v82, Lcom/android/server/ConsumerIrService;

    move-object/from16 v0, v82

    invoke-direct {v0, v5}, Lcom/android/server/ConsumerIrService;-><init>(Landroid/content/Context;)V
    :try_end_f
    .catch Ljava/lang/RuntimeException; {:try_start_f .. :try_end_f} :catch_65

    .line 357
    .end local v81           #consumerIr:Lcom/android/server/ConsumerIrService;
    .local v82, consumerIr:Lcom/android/server/ConsumerIrService;
    :try_start_10
    const-string v7, "consumer_ir"

    move-object/from16 v0, v82

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 361
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v7

    invoke-static {}, Lcom/android/server/am/BatteryStatsService;->getService()Lcom/android/internal/app/IBatteryStats;

    move-result-object v9

    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v10

    invoke-virtual {v10}, Lcom/android/server/am/ActivityManagerService;->getAppOpsService()Lcom/android/internal/app/IAppOpsService;

    move-result-object v10

    invoke-virtual/range {v4 .. v11}, Lcom/android/server/power/PowerManagerService;->init(Landroid/content/Context;Lcom/android/server/LightsService;Lcom/android/server/am/ActivityManagerService;Lcom/android/server/BatteryService;Lcom/android/internal/app/IBatteryStats;Lcom/android/internal/app/IAppOpsService;Lcom/android/server/display/DisplayManagerService;)V

    .line 365
    const-string v7, "SystemServer"

    const-string v9, "Alarm Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 366
    new-instance v16, Lcom/android/server/AlarmManagerService;

    move-object/from16 v0, v16

    invoke-direct {v0, v5}, Lcom/android/server/AlarmManagerService;-><init>(Landroid/content/Context;)V
    :try_end_10
    .catch Ljava/lang/RuntimeException; {:try_start_10 .. :try_end_10} :catch_66

    .line 367
    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .local v16, alarm:Lcom/android/server/AlarmManagerService;
    :try_start_11
    const-string v7, "alarm"

    move-object/from16 v0, v16

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 369
    const-string v7, "SystemServer"

    const-string v9, "Init Watchdog"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 370
    invoke-static {}, Lcom/android/server/Watchdog;->getInstance()Lcom/android/server/Watchdog;

    move-result-object v12

    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v17

    move-object v13, v5

    move-object v14, v8

    move-object v15, v4

    invoke-virtual/range {v12 .. v17}, Lcom/android/server/Watchdog;->init(Landroid/content/Context;Lcom/android/server/BatteryService;Lcom/android/server/power/PowerManagerService;Lcom/android/server/AlarmManagerService;Lcom/android/server/am/ActivityManagerService;)V

    .line 372
    invoke-static {}, Lcom/android/server/Watchdog;->getInstance()Lcom/android/server/Watchdog;

    move-result-object v7

    const-string v9, "WindowManager thread"

    move-object/from16 v0, v21

    invoke-virtual {v7, v0, v9}, Lcom/android/server/Watchdog;->addThread(Landroid/os/Handler;Ljava/lang/String;)V

    .line 374
    const-string v7, "SystemServer"

    const-string v9, "Input Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 375
    new-instance v20, Lcom/android/server/input/InputManagerService;

    move-object/from16 v0, v20

    move-object/from16 v1, v21

    invoke-direct {v0, v5, v1}, Lcom/android/server/input/InputManagerService;-><init>(Landroid/content/Context;Landroid/os/Handler;)V
    :try_end_11
    .catch Ljava/lang/RuntimeException; {:try_start_11 .. :try_end_11} :catch_67

    .line 377
    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .local v20, inputManager:Lcom/android/server/input/InputManagerService;
    :try_start_12
    const-string v7, "SystemServer"

    const-string v9, "Window Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 378
    const/4 v7, 0x1

    move/from16 v0, v106

    if-eq v0, v7, :cond_2f

    const/16 v22, 0x1

    :goto_9
    if-nez v109, :cond_30

    const/16 v23, 0x1

    :goto_a
    move-object/from16 v17, v5

    move-object/from16 v18, v4

    move-object/from16 v19, v11

    invoke-static/range {v17 .. v24}, Lcom/android/server/wm/WindowManagerService;->main(Landroid/content/Context;Lcom/android/server/power/PowerManagerService;Lcom/android/server/display/DisplayManagerService;Lcom/android/server/input/InputManagerService;Landroid/os/Handler;ZZZ)Lcom/android/server/wm/WindowManagerService;

    move-result-object v180

    .line 381
    const-string v7, "window"

    move-object/from16 v0, v180

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 382
    const-string v7, "input"

    move-object/from16 v0, v20

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 384
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v7

    move-object/from16 v0, v180

    invoke-virtual {v7, v0}, Lcom/android/server/am/ActivityManagerService;->setWindowManager(Lcom/android/server/wm/WindowManagerService;)V

    .line 386
    invoke-virtual/range {v180 .. v180}, Lcom/android/server/wm/WindowManagerService;->getInputMonitor()Lcom/android/server/wm/InputMonitor;

    move-result-object v7

    move-object/from16 v0, v20

    invoke-virtual {v0, v7}, Lcom/android/server/input/InputManagerService;->setWindowManagerCallbacks(Lcom/android/server/input/InputManagerService$WindowManagerCallbacks;)V

    .line 387
    invoke-virtual/range {v20 .. v20}, Lcom/android/server/input/InputManagerService;->start()V

    .line 389
    move-object/from16 v0, v180

    invoke-virtual {v11, v0}, Lcom/android/server/display/DisplayManagerService;->setWindowManager(Lcom/android/server/display/DisplayManagerService$WindowManagerFuncs;)V

    .line 390
    move-object/from16 v0, v20

    invoke-virtual {v11, v0}, Lcom/android/server/display/DisplayManagerService;->setInputManager(Lcom/android/server/display/DisplayManagerService$InputManagerFuncs;)V

    .line 395
    const-string v7, "ro.kernel.qemu"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v9, "1"

    invoke-virtual {v7, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_31

    .line 396
    const-string v7, "SystemServer"

    const-string v9, "No Bluetooh Service (emulator)"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_12
    .catch Ljava/lang/RuntimeException; {:try_start_12 .. :try_end_12} :catch_3

    :goto_b
    move-object/from16 v81, v82

    .end local v82           #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v81       #consumerIr:Lcom/android/server/ConsumerIrService;
    move-object/from16 v159, v160

    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v171, v172

    .line 414
    .end local v86           #cryptState:Ljava/lang/String;
    .end local v172           #vibrator:Lcom/android/server/VibratorService;
    .restart local v171       #vibrator:Lcom/android/server/VibratorService;
    :goto_c
    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v9, 0x1110067

    invoke-virtual {v7, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v112

    .line 417
    .local v112, hasRotationLock:Z
    const/16 v87, 0x0

    .line 418
    .local v87, devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    const/16 v157, 0x0

    .line 419
    .local v157, statusBar:Lcom/android/server/StatusBarManagerService;
    const/16 v113, 0x0

    .line 420
    .local v113, imm:Lcom/android/server/InputMethodManagerService;
    const/16 v68, 0x0

    .line 421
    .local v68, appWidget:Lcom/android/server/AppWidgetService;
    const/16 v141, 0x0

    .line 422
    .local v141, profile:Lcom/android/server/ProfileManagerService;
    const/16 v134, 0x0

    .line 423
    .local v134, notification:Lcom/android/server/NotificationManagerService;
    const/16 v174, 0x0

    .line 424
    .local v174, wallpaper:Lcom/android/server/WallpaperManagerService;
    const/16 v119, 0x0

    .line 425
    .local v119, location:Lcom/android/server/LocationManagerService;
    const/16 v84, 0x0

    .line 426
    .local v84, countryDetector:Lcom/android/server/CountryDetectorService;
    const/16 v163, 0x0

    .line 427
    .local v163, tsms:Lcom/android/server/TextServicesManagerService;
    const/16 v121, 0x0

    .line 428
    .local v121, lockSettings:Lcom/android/server/LockSettingsService;
    const/16 v100, 0x0

    .line 429
    .local v100, dreamy:Lcom/android/server/dreams/DreamManagerService;
    const/16 v70, 0x0

    .line 430
    .local v70, atlas:Lcom/android/server/AssetAtlasService;
    const/16 v139, 0x0

    .line 431
    .local v139, printManager:Lcom/android/server/print/PrintManagerService;
    const/16 v110, 0x0

    .line 432
    .local v110, gestureService:Lcom/android/server/gesture/GestureService;
    const/16 v123, 0x0

    .line 433
    .local v123, mediaRouter:Lcom/android/server/media/MediaRouterService;
    const/16 v161, 0x0

    .line 434
    .local v161, themeService:Lcom/android/server/ThemeService;
    const/16 v103, 0x0

    .line 437
    .local v103, edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    const/4 v7, 0x1

    move/from16 v0, v106

    if-eq v0, v7, :cond_4

    .line 441
    :try_start_13
    const-string v7, "SystemServer"

    const-string v9, "Input Method Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 442
    new-instance v114, Lcom/android/server/InputMethodManagerService;

    move-object/from16 v0, v114

    move-object/from16 v1, v180

    invoke-direct {v0, v5, v1}, Lcom/android/server/InputMethodManagerService;-><init>(Landroid/content/Context;Lcom/android/server/wm/WindowManagerService;)V
    :try_end_13
    .catch Ljava/lang/Throwable; {:try_start_13 .. :try_end_13} :catch_4

    .line 443
    .end local v113           #imm:Lcom/android/server/InputMethodManagerService;
    .local v114, imm:Lcom/android/server/InputMethodManagerService;
    :try_start_14
    const-string v7, "input_method"

    move-object/from16 v0, v114

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_14
    .catch Ljava/lang/Throwable; {:try_start_14 .. :try_end_14} :catch_5e

    move-object/from16 v113, v114

    .line 449
    .end local v114           #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v113       #imm:Lcom/android/server/InputMethodManagerService;
    :goto_d
    :try_start_15
    const-string v7, "SystemServer"

    const-string v9, "Accessibility Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 450
    const-string v7, "accessibility"

    new-instance v9, Lcom/android/server/accessibility/AccessibilityManagerService;

    invoke-direct {v9, v5}, Lcom/android/server/accessibility/AccessibilityManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_15
    .catch Ljava/lang/Throwable; {:try_start_15 .. :try_end_15} :catch_5

    .line 459
    :cond_4
    :goto_e
    :try_start_16
    invoke-virtual/range {v180 .. v180}, Lcom/android/server/wm/WindowManagerService;->displayReady()V
    :try_end_16
    .catch Ljava/lang/Throwable; {:try_start_16 .. :try_end_16} :catch_6

    .line 465
    :goto_f
    :try_start_17
    invoke-interface/range {v137 .. v137}, Landroid/content/pm/IPackageManager;->performBootDexOpt()V
    :try_end_17
    .catch Ljava/lang/Throwable; {:try_start_17 .. :try_end_17} :catch_7

    .line 471
    :goto_10
    :try_start_18
    invoke-static {}, Landroid/app/ActivityManagerNative;->getDefault()Landroid/app/IActivityManager;

    move-result-object v7

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    const v10, 0x10404c0

    invoke-virtual {v9, v10}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v9

    const/4 v10, 0x0

    invoke-interface {v7, v9, v10}, Landroid/app/IActivityManager;->showBootMessage(Ljava/lang/CharSequence;Z)V
    :try_end_18
    .catch Landroid/os/RemoteException; {:try_start_18 .. :try_end_18} :catch_5d

    .line 478
    :goto_11
    const/4 v7, 0x1

    move/from16 v0, v106

    if-eq v0, v7, :cond_39

    .line 479
    if-nez v94, :cond_5

    const-string v7, "0"

    const-string v9, "system_init.startmountservice"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_5

    .line 486
    :try_start_19
    const-string v7, "SystemServer"

    const-string v9, "Mount Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 487
    new-instance v127, Lcom/android/server/MountService;

    move-object/from16 v0, v127

    invoke-direct {v0, v5}, Lcom/android/server/MountService;-><init>(Landroid/content/Context;)V
    :try_end_19
    .catch Ljava/lang/Throwable; {:try_start_19 .. :try_end_19} :catch_8

    .line 488
    .end local v126           #mountService:Lcom/android/server/MountService;
    .local v127, mountService:Lcom/android/server/MountService;
    :try_start_1a
    const-string v7, "mount"

    move-object/from16 v0, v127

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1a
    .catch Ljava/lang/Throwable; {:try_start_1a .. :try_end_1a} :catch_5c

    move-object/from16 v126, v127

    .line 494
    .end local v127           #mountService:Lcom/android/server/MountService;
    .restart local v126       #mountService:Lcom/android/server/MountService;
    :cond_5
    :goto_12
    if-nez v93, :cond_6

    .line 496
    :try_start_1b
    const-string v7, "SystemServer"

    const-string v9, "LockSettingsService"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 497
    new-instance v122, Lcom/android/server/LockSettingsService;

    move-object/from16 v0, v122

    invoke-direct {v0, v5}, Lcom/android/server/LockSettingsService;-><init>(Landroid/content/Context;)V
    :try_end_1b
    .catch Ljava/lang/Throwable; {:try_start_1b .. :try_end_1b} :catch_9

    .line 498
    .end local v121           #lockSettings:Lcom/android/server/LockSettingsService;
    .local v122, lockSettings:Lcom/android/server/LockSettingsService;
    :try_start_1c
    const-string v7, "lock_settings"

    move-object/from16 v0, v122

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1c
    .catch Ljava/lang/Throwable; {:try_start_1c .. :try_end_1c} :catch_5b

    move-object/from16 v121, v122

    .line 504
    .end local v122           #lockSettings:Lcom/android/server/LockSettingsService;
    .restart local v121       #lockSettings:Lcom/android/server/LockSettingsService;
    :goto_13
    :try_start_1d
    const-string v7, "SystemServer"

    const-string v9, "Device Policy"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 505
    new-instance v88, Lcom/android/server/DevicePolicyManagerService;

    move-object/from16 v0, v88

    invoke-direct {v0, v5}, Lcom/android/server/DevicePolicyManagerService;-><init>(Landroid/content/Context;)V
    :try_end_1d
    .catch Ljava/lang/Throwable; {:try_start_1d .. :try_end_1d} :catch_a

    .line 506
    .end local v87           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .local v88, devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    :try_start_1e
    const-string v7, "device_policy"

    move-object/from16 v0, v88

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1e
    .catch Ljava/lang/Throwable; {:try_start_1e .. :try_end_1e} :catch_5a

    move-object/from16 v87, v88

    .line 512
    .end local v88           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v87       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    :cond_6
    :goto_14
    if-nez v95, :cond_7

    .line 514
    :try_start_1f
    const-string v7, "SystemServer"

    const-string v9, "Status Bar"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 515
    new-instance v158, Lcom/android/server/StatusBarManagerService;

    move-object/from16 v0, v158

    move-object/from16 v1, v180

    invoke-direct {v0, v5, v1}, Lcom/android/server/StatusBarManagerService;-><init>(Landroid/content/Context;Lcom/android/server/wm/WindowManagerService;)V
    :try_end_1f
    .catch Ljava/lang/Throwable; {:try_start_1f .. :try_end_1f} :catch_b

    .line 516
    .end local v157           #statusBar:Lcom/android/server/StatusBarManagerService;
    .local v158, statusBar:Lcom/android/server/StatusBarManagerService;
    :try_start_20
    const-string v7, "statusbar"

    move-object/from16 v0, v158

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_20
    .catch Ljava/lang/Throwable; {:try_start_20 .. :try_end_20} :catch_59

    move-object/from16 v157, v158

    .line 522
    .end local v158           #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v157       #statusBar:Lcom/android/server/StatusBarManagerService;
    :cond_7
    :goto_15
    if-nez v93, :cond_8

    .line 524
    :try_start_21
    const-string v7, "SystemServer"

    const-string v9, "Clipboard Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 525
    const-string v7, "clipboard"

    new-instance v9, Lcom/android/server/ClipboardService;

    invoke-direct {v9, v5}, Lcom/android/server/ClipboardService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    const-string v7, "miui.clipserviceext"

    new-instance v9, Lcom/miui/server/ClipServiceExtra;

    invoke-direct {v9}, Lcom/miui/server/ClipServiceExtra;-><init>()V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_21
    .catch Ljava/lang/Throwable; {:try_start_21 .. :try_end_21} :catch_c

    .line 532
    :cond_8
    :goto_16
    if-nez v92, :cond_9

    .line 534
    :try_start_22
    const-string v7, "SystemServer"

    const-string v9, "NetworkManagement Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 535
    invoke-static {v5}, Lcom/android/server/NetworkManagementService;->create(Landroid/content/Context;)Lcom/android/server/NetworkManagementService;

    move-result-object v30

    .line 536
    const-string v7, "network_management"

    move-object/from16 v0, v30

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_22
    .catch Ljava/lang/Throwable; {:try_start_22 .. :try_end_22} :catch_d

    .line 542
    :cond_9
    :goto_17
    if-nez v93, :cond_a

    .line 544
    :try_start_23
    const-string v7, "SystemServer"

    const-string v9, "Text Service Manager Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 545
    new-instance v164, Lcom/android/server/TextServicesManagerService;

    move-object/from16 v0, v164

    invoke-direct {v0, v5}, Lcom/android/server/TextServicesManagerService;-><init>(Landroid/content/Context;)V
    :try_end_23
    .catch Ljava/lang/Throwable; {:try_start_23 .. :try_end_23} :catch_e

    .line 546
    .end local v163           #tsms:Lcom/android/server/TextServicesManagerService;
    .local v164, tsms:Lcom/android/server/TextServicesManagerService;
    :try_start_24
    const-string v7, "textservices"

    move-object/from16 v0, v164

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_24
    .catch Ljava/lang/Throwable; {:try_start_24 .. :try_end_24} :catch_58

    move-object/from16 v163, v164

    .line 552
    .end local v164           #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v163       #tsms:Lcom/android/server/TextServicesManagerService;
    :cond_a
    :goto_18
    if-nez v92, :cond_38

    .line 554
    :try_start_25
    const-string v7, "SystemServer"

    const-string v9, "NetworkStats Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 555
    new-instance v131, Lcom/android/server/net/NetworkStatsService;

    move-object/from16 v0, v131

    move-object/from16 v1, v30

    move-object/from16 v2, v16

    invoke-direct {v0, v5, v1, v2}, Lcom/android/server/net/NetworkStatsService;-><init>(Landroid/content/Context;Landroid/os/INetworkManagementService;Landroid/app/IAlarmManager;)V
    :try_end_25
    .catch Ljava/lang/Throwable; {:try_start_25 .. :try_end_25} :catch_f

    .line 556
    .end local v29           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .local v131, networkStats:Lcom/android/server/net/NetworkStatsService;
    :try_start_26
    const-string v7, "netstats"

    move-object/from16 v0, v131

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_26
    .catch Ljava/lang/Throwable; {:try_start_26 .. :try_end_26} :catch_57

    move-object/from16 v29, v131

    .line 562
    .end local v131           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v29       #networkStats:Lcom/android/server/net/NetworkStatsService;
    :goto_19
    :try_start_27
    const-string v7, "SystemServer"

    const-string v9, "NetworkPolicy Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 563
    new-instance v25, Lcom/android/server/net/NetworkPolicyManagerService;

    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v27

    move-object/from16 v26, v5

    move-object/from16 v28, v4

    invoke-direct/range {v25 .. v30}, Lcom/android/server/net/NetworkPolicyManagerService;-><init>(Landroid/content/Context;Landroid/app/IActivityManager;Landroid/os/IPowerManager;Landroid/net/INetworkStatsService;Landroid/os/INetworkManagementService;)V
    :try_end_27
    .catch Ljava/lang/Throwable; {:try_start_27 .. :try_end_27} :catch_10

    .line 566
    .end local v130           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .local v25, networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    :try_start_28
    const-string v7, "netpolicy"

    move-object/from16 v0, v25

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_28
    .catch Ljava/lang/Throwable; {:try_start_28 .. :try_end_28} :catch_56

    .line 572
    :goto_1a
    :try_start_29
    const-string v7, "SystemServer"

    const-string v9, "Wi-Fi P2pService"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 573
    new-instance v179, Landroid/net/wifi/p2p/WifiP2pService;

    move-object/from16 v0, v179

    invoke-direct {v0, v5}, Landroid/net/wifi/p2p/WifiP2pService;-><init>(Landroid/content/Context;)V
    :try_end_29
    .catch Ljava/lang/Throwable; {:try_start_29 .. :try_end_29} :catch_11

    .line 574
    .end local v178           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .local v179, wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    :try_start_2a
    const-string v7, "wifip2p"

    move-object/from16 v0, v179

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_2a
    .catch Ljava/lang/Throwable; {:try_start_2a .. :try_end_2a} :catch_55

    move-object/from16 v178, v179

    .line 580
    .end local v179           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v178       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    :goto_1b
    :try_start_2b
    const-string v7, "SystemServer"

    const-string v9, "Wi-Fi Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 581
    new-instance v177, Lcom/android/server/wifi/WifiService;

    move-object/from16 v0, v177

    invoke-direct {v0, v5}, Lcom/android/server/wifi/WifiService;-><init>(Landroid/content/Context;)V
    :try_end_2b
    .catch Ljava/lang/Throwable; {:try_start_2b .. :try_end_2b} :catch_12

    .line 582
    .end local v176           #wifi:Lcom/android/server/wifi/WifiService;
    .local v177, wifi:Lcom/android/server/wifi/WifiService;
    :try_start_2c
    const-string v7, "wifi"

    move-object/from16 v0, v177

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_2c
    .catch Ljava/lang/Throwable; {:try_start_2c .. :try_end_2c} :catch_54

    move-object/from16 v176, v177

    .line 588
    .end local v177           #wifi:Lcom/android/server/wifi/WifiService;
    .restart local v176       #wifi:Lcom/android/server/wifi/WifiService;
    :goto_1c
    const/16 v105, 0x1

    .line 589
    .local v105, enableCne:I
    :try_start_2d
    invoke-static {}, Lcom/android/server/ServerThread;->deviceHasSufficientMemory()Z

    move-result v7

    if-nez v7, :cond_b

    .line 590
    const-string v7, "persist.cne.override.memlimit"

    const/4 v9, 0x0

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v105

    .line 592
    :cond_b
    const/4 v7, 0x1

    move/from16 v0, v105

    if-ne v0, v7, :cond_35

    const-string v7, "persist.cne.feature"

    const/4 v9, 0x0

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I
    :try_end_2d
    .catch Ljava/lang/Throwable; {:try_start_2d .. :try_end_2d} :catch_14

    move-result v75

    .line 596
    .local v75, cneFeature:I
    :goto_1d
    if-lez v75, :cond_36

    const/16 v7, 0xa

    move/from16 v0, v75

    if-ge v0, v7, :cond_36

    .line 597
    :try_start_2e
    const-string v7, "SystemServer"

    const-string v9, "QcConnectivity Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 598
    new-instance v145, Ldalvik/system/PathClassLoader;

    const-string v7, "/system/framework/services-ext.jar"

    invoke-static {}, Ljava/lang/ClassLoader;->getSystemClassLoader()Ljava/lang/ClassLoader;

    move-result-object v9

    move-object/from16 v0, v145

    invoke-direct {v0, v7, v9}, Ldalvik/system/PathClassLoader;-><init>(Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .line 601
    .local v145, qcsClassLoader:Ldalvik/system/PathClassLoader;
    const-string v7, "com.android.server.QcConnectivityService"

    move-object/from16 v0, v145

    invoke-virtual {v0, v7}, Ldalvik/system/PathClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v144

    .line 603
    .local v144, qcsClass:Ljava/lang/Class;
    const/4 v7, 0x4

    new-array v7, v7, [Ljava/lang/Class;

    const/4 v9, 0x0

    const-class v10, Landroid/content/Context;

    aput-object v10, v7, v9

    const/4 v9, 0x1

    const-class v10, Landroid/os/INetworkManagementService;

    aput-object v10, v7, v9

    const/4 v9, 0x2

    const-class v10, Landroid/net/INetworkStatsService;

    aput-object v10, v7, v9

    const/4 v9, 0x3

    const-class v10, Landroid/net/INetworkPolicyManager;

    aput-object v10, v7, v9

    move-object/from16 v0, v144

    invoke-virtual {v0, v7}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v146

    .line 606
    .local v146, qcsConstructor:Ljava/lang/reflect/Constructor;
    const/4 v7, 0x4

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v9, 0x0

    aput-object v5, v7, v9

    const/4 v9, 0x1

    aput-object v30, v7, v9

    const/4 v9, 0x2

    aput-object v29, v7, v9

    const/4 v9, 0x3

    aput-object v25, v7, v9

    move-object/from16 v0, v146

    invoke-virtual {v0, v7}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v143

    .line 608
    move-object/from16 v0, v143

    check-cast v0, Lcom/android/server/ConnectivityService;

    move-object/from16 v79, v0
    :try_end_2e
    .catch Ljava/lang/Throwable; {:try_start_2e .. :try_end_2e} :catch_13

    .line 619
    .end local v143           #qcCon:Ljava/lang/Object;
    .end local v144           #qcsClass:Ljava/lang/Class;
    .end local v145           #qcsClassLoader:Ldalvik/system/PathClassLoader;
    .end local v146           #qcsConstructor:Ljava/lang/reflect/Constructor;
    :goto_1e
    if-eqz v79, :cond_c

    .line 620
    :try_start_2f
    const-string v7, "connectivity"

    move-object/from16 v0, v79

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 621
    move-object/from16 v0, v29

    move-object/from16 v1, v79

    invoke-virtual {v0, v1}, Lcom/android/server/net/NetworkStatsService;->bindConnectivityManager(Landroid/net/IConnectivityManager;)V

    .line 622
    move-object/from16 v0, v25

    move-object/from16 v1, v79

    invoke-virtual {v0, v1}, Lcom/android/server/net/NetworkPolicyManagerService;->bindConnectivityManager(Landroid/net/IConnectivityManager;)V

    .line 623
    invoke-virtual/range {v176 .. v176}, Lcom/android/server/wifi/WifiService;->checkAndStartWifi()V

    .line 624
    invoke-virtual/range {v178 .. v178}, Landroid/net/wifi/p2p/WifiP2pService;->connectivityServiceReady()V
    :try_end_2f
    .catch Ljava/lang/Throwable; {:try_start_2f .. :try_end_2f} :catch_14

    .line 631
    .end local v75           #cneFeature:I
    :cond_c
    :goto_1f
    :try_start_30
    const-string v7, "SystemServer"

    const-string v9, "Network Service Discovery Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 632
    invoke-static {v5}, Lcom/android/server/NsdService;->create(Landroid/content/Context;)Lcom/android/server/NsdService;

    move-result-object v155

    .line 633
    const-string v7, "servicediscovery"

    move-object/from16 v0, v155

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_30
    .catch Ljava/lang/Throwable; {:try_start_30 .. :try_end_30} :catch_15

    .line 640
    .end local v105           #enableCne:I
    :goto_20
    if-nez v93, :cond_d

    .line 642
    :try_start_31
    const-string v7, "SystemServer"

    const-string v9, "UpdateLock Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 643
    const-string v7, "updatelock"

    new-instance v9, Lcom/android/server/UpdateLockService;

    invoke-direct {v9, v5}, Lcom/android/server/UpdateLockService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_31
    .catch Ljava/lang/Throwable; {:try_start_31 .. :try_end_31} :catch_16

    .line 655
    :cond_d
    :goto_21
    if-eqz v126, :cond_e

    if-nez v24, :cond_e

    .line 656
    invoke-virtual/range {v126 .. v126}, Lcom/android/server/MountService;->waitForAsecScan()V

    .line 660
    :cond_e
    if-eqz v65, :cond_f

    .line 661
    :try_start_32
    invoke-virtual/range {v65 .. v65}, Lcom/android/server/accounts/AccountManagerService;->systemReady()V
    :try_end_32
    .catch Ljava/lang/Throwable; {:try_start_32 .. :try_end_32} :catch_17

    .line 667
    :cond_f
    :goto_22
    if-eqz v83, :cond_10

    .line 668
    :try_start_33
    invoke-virtual/range {v83 .. v83}, Lcom/android/server/content/ContentService;->systemReady()V
    :try_end_33
    .catch Ljava/lang/Throwable; {:try_start_33 .. :try_end_33} :catch_18

    .line 674
    :cond_10
    :goto_23
    :try_start_34
    const-string v7, "SystemServer"

    const-string v9, "Profile Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 675
    new-instance v142, Lcom/android/server/ProfileManagerService;

    move-object/from16 v0, v142

    invoke-direct {v0, v5}, Lcom/android/server/ProfileManagerService;-><init>(Landroid/content/Context;)V
    :try_end_34
    .catch Ljava/lang/Throwable; {:try_start_34 .. :try_end_34} :catch_19

    .line 676
    .end local v141           #profile:Lcom/android/server/ProfileManagerService;
    .local v142, profile:Lcom/android/server/ProfileManagerService;
    :try_start_35
    const-string v7, "profile"

    move-object/from16 v0, v142

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_35
    .catch Ljava/lang/Throwable; {:try_start_35 .. :try_end_35} :catch_53

    move-object/from16 v141, v142

    .line 682
    .end local v142           #profile:Lcom/android/server/ProfileManagerService;
    .restart local v141       #profile:Lcom/android/server/ProfileManagerService;
    :goto_24
    :try_start_36
    const-string v7, "SystemServer"

    const-string v9, "Notification Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 683
    new-instance v135, Lcom/android/server/NotificationManagerService;

    move-object/from16 v0, v135

    move-object/from16 v1, v157

    invoke-direct {v0, v5, v1, v6}, Lcom/android/server/NotificationManagerService;-><init>(Landroid/content/Context;Lcom/android/server/StatusBarManagerService;Lcom/android/server/LightsService;)V
    :try_end_36
    .catch Ljava/lang/Throwable; {:try_start_36 .. :try_end_36} :catch_1a

    .line 684
    .end local v134           #notification:Lcom/android/server/NotificationManagerService;
    .local v135, notification:Lcom/android/server/NotificationManagerService;
    :try_start_37
    const-string v7, "notification"

    move-object/from16 v0, v135

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 685
    move-object/from16 v0, v25

    move-object/from16 v1, v135

    invoke-virtual {v0, v1}, Lcom/android/server/net/NetworkPolicyManagerService;->bindNotificationManager(Landroid/app/INotificationManager;)V
    :try_end_37
    .catch Ljava/lang/Throwable; {:try_start_37 .. :try_end_37} :catch_52

    move-object/from16 v134, v135

    .line 691
    .end local v135           #notification:Lcom/android/server/NotificationManagerService;
    .restart local v134       #notification:Lcom/android/server/NotificationManagerService;
    :goto_25
    :try_start_38
    const-string v7, "SystemServer"

    const-string v9, "Device Storage Monitor"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 692
    const-string v7, "devicestoragemonitor"

    new-instance v9, Lcom/android/server/DeviceStorageMonitorService;

    invoke-direct {v9, v5}, Lcom/android/server/DeviceStorageMonitorService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    invoke-static {}, Lcom/android/server/ServerThread$Injector;->setMemoryLowThresholdProperty()V
    :try_end_38
    .catch Ljava/lang/Throwable; {:try_start_38 .. :try_end_38} :catch_1b

    .line 698
    :goto_26
    if-nez v90, :cond_11

    .line 700
    :try_start_39
    const-string v7, "SystemServer"

    const-string v9, "Location Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 701
    new-instance v120, Lcom/android/server/LocationManagerService;

    move-object/from16 v0, v120

    invoke-direct {v0, v5}, Lcom/android/server/LocationManagerService;-><init>(Landroid/content/Context;)V
    :try_end_39
    .catch Ljava/lang/Throwable; {:try_start_39 .. :try_end_39} :catch_1c

    .line 702
    .end local v119           #location:Lcom/android/server/LocationManagerService;
    .local v120, location:Lcom/android/server/LocationManagerService;
    :try_start_3a
    const-string v7, "location"

    move-object/from16 v0, v120

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3a
    .catch Ljava/lang/Throwable; {:try_start_3a .. :try_end_3a} :catch_51

    move-object/from16 v119, v120

    .line 708
    .end local v120           #location:Lcom/android/server/LocationManagerService;
    .restart local v119       #location:Lcom/android/server/LocationManagerService;
    :goto_27
    :try_start_3b
    const-string v7, "SystemServer"

    const-string v9, "Country Detector"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 709
    new-instance v85, Lcom/android/server/CountryDetectorService;

    move-object/from16 v0, v85

    invoke-direct {v0, v5}, Lcom/android/server/CountryDetectorService;-><init>(Landroid/content/Context;)V
    :try_end_3b
    .catch Ljava/lang/Throwable; {:try_start_3b .. :try_end_3b} :catch_1d

    .line 710
    .end local v84           #countryDetector:Lcom/android/server/CountryDetectorService;
    .local v85, countryDetector:Lcom/android/server/CountryDetectorService;
    :try_start_3c
    const-string v7, "country_detector"

    move-object/from16 v0, v85

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3c
    .catch Ljava/lang/Throwable; {:try_start_3c .. :try_end_3c} :catch_50

    move-object/from16 v84, v85

    .line 716
    .end local v85           #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v84       #countryDetector:Lcom/android/server/CountryDetectorService;
    :cond_11
    :goto_28
    if-nez v93, :cond_12

    .line 718
    :try_start_3d
    const-string v7, "SystemServer"

    const-string v9, "Search Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 719
    const-string v7, "search"

    new-instance v9, Lcom/android/server/search/SearchManagerService;

    invoke-direct {v9, v5}, Lcom/android/server/search/SearchManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3d
    .catch Ljava/lang/Throwable; {:try_start_3d .. :try_end_3d} :catch_1e

    .line 727
    :cond_12
    :goto_29
    :try_start_3e
    const-string v7, "SystemServer"

    const-string v9, "DropBox Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 728
    const-string v7, "dropbox"

    new-instance v9, Lcom/android/server/DropBoxManagerService;

    new-instance v10, Ljava/io/File;

    const-string v12, "/data/system/dropbox"

    invoke-direct {v10, v12}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v9, v5, v10}, Lcom/android/server/DropBoxManagerService;-><init>(Landroid/content/Context;Ljava/io/File;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3e
    .catch Ljava/lang/Throwable; {:try_start_3e .. :try_end_3e} :catch_1f

    .line 734
    :goto_2a
    if-nez v93, :cond_13

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v9, 0x1110039

    invoke-virtual {v7, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v7

    if-eqz v7, :cond_13

    .line 737
    :try_start_3f
    const-string v7, "SystemServer"

    const-string v9, "Wallpaper Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 738
    if-nez v33, :cond_13

    .line 739
    new-instance v175, Lcom/android/server/WallpaperManagerService;

    move-object/from16 v0, v175

    invoke-direct {v0, v5}, Lcom/android/server/WallpaperManagerService;-><init>(Landroid/content/Context;)V
    :try_end_3f
    .catch Ljava/lang/Throwable; {:try_start_3f .. :try_end_3f} :catch_20

    .line 740
    .end local v174           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .local v175, wallpaper:Lcom/android/server/WallpaperManagerService;
    :try_start_40
    const-string v7, "wallpaper"

    move-object/from16 v0, v175

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    const-string v7, "miui.usb.service"

    new-instance v9, Lcom/miui/server/MiuiUsbService;

    invoke-direct {v9, v5}, Lcom/miui/server/MiuiUsbService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    const-string v7, "miui.os.servicemanager"

    new-instance v9, Landroid/os/MiuiServiceManagerInternal;

    invoke-direct {v9}, Landroid/os/MiuiServiceManagerInternal;-><init>()V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_40
    .catch Ljava/lang/Throwable; {:try_start_40 .. :try_end_40} :catch_4f

    move-object/from16 v174, v175

    .line 747
    .end local v175           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v174       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :cond_13
    :goto_2b
    if-nez v91, :cond_14

    const-string v7, "0"

    const-string v9, "system_init.startaudioservice"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_14

    .line 749
    :try_start_41
    const-string v7, "SystemServer"

    const-string v9, "Audio Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 750
    const-string v7, "audio"

    new-instance v9, Landroid/media/AudioService;

    invoke-direct {v9, v5}, Landroid/media/AudioService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_41
    .catch Ljava/lang/Throwable; {:try_start_41 .. :try_end_41} :catch_21

    .line 756
    :cond_14
    :goto_2c
    if-nez v93, :cond_15

    .line 758
    :try_start_42
    const-string v7, "SystemServer"

    const-string v9, "Dock Observer"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 760
    new-instance v99, Lcom/android/server/DockObserver;

    move-object/from16 v0, v99

    invoke-direct {v0, v5}, Lcom/android/server/DockObserver;-><init>(Landroid/content/Context;)V
    :try_end_42
    .catch Ljava/lang/Throwable; {:try_start_42 .. :try_end_42} :catch_22

    .end local v98           #dock:Lcom/android/server/DockObserver;
    .local v99, dock:Lcom/android/server/DockObserver;
    move-object/from16 v98, v99

    .line 766
    .end local v99           #dock:Lcom/android/server/DockObserver;
    .restart local v98       #dock:Lcom/android/server/DockObserver;
    :cond_15
    :goto_2d
    if-nez v91, :cond_16

    .line 768
    :try_start_43
    const-string v7, "SystemServer"

    const-string v9, "Wired Accessory Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 770
    new-instance v7, Lcom/android/server/WiredAccessoryManager;

    move-object/from16 v0, v20

    invoke-direct {v7, v5, v0}, Lcom/android/server/WiredAccessoryManager;-><init>(Landroid/content/Context;Lcom/android/server/input/InputManagerService;)V

    move-object/from16 v0, v20

    invoke-virtual {v0, v7}, Lcom/android/server/input/InputManagerService;->setWiredAccessoryCallbacks(Lcom/android/server/input/InputManagerService$WiredAccessoryCallbacks;)V
    :try_end_43
    .catch Ljava/lang/Throwable; {:try_start_43 .. :try_end_43} :catch_23

    .line 778
    :cond_16
    :goto_2e
    if-eqz v112, :cond_17

    .line 779
    :try_start_44
    const-string v7, "SystemServer"

    const-string v9, "Rotation Switch Observer"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 781
    new-instance v152, Lcom/android/server/RotationSwitchObserver;

    move-object/from16 v0, v152

    invoke-direct {v0, v5}, Lcom/android/server/RotationSwitchObserver;-><init>(Landroid/content/Context;)V
    :try_end_44
    .catch Ljava/lang/Throwable; {:try_start_44 .. :try_end_44} :catch_24

    .end local v151           #rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    .local v152, rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    move-object/from16 v151, v152

    .line 787
    .end local v152           #rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    .restart local v151       #rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    :cond_17
    :goto_2f
    if-nez v93, :cond_18

    .line 789
    :try_start_45
    const-string v7, "SystemServer"

    const-string v9, "USB Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 791
    new-instance v170, Lcom/android/server/usb/UsbService;

    move-object/from16 v0, v170

    invoke-direct {v0, v5}, Lcom/android/server/usb/UsbService;-><init>(Landroid/content/Context;)V
    :try_end_45
    .catch Ljava/lang/Throwable; {:try_start_45 .. :try_end_45} :catch_25

    .line 792
    .end local v169           #usb:Lcom/android/server/usb/UsbService;
    .local v170, usb:Lcom/android/server/usb/UsbService;
    :try_start_46
    const-string v7, "usb"

    move-object/from16 v0, v170

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_46
    .catch Ljava/lang/Throwable; {:try_start_46 .. :try_end_46} :catch_4e

    move-object/from16 v169, v170

    .line 798
    .end local v170           #usb:Lcom/android/server/usb/UsbService;
    .restart local v169       #usb:Lcom/android/server/usb/UsbService;
    :goto_30
    :try_start_47
    const-string v7, "SystemServer"

    const-string v9, "Serial Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 800
    new-instance v154, Lcom/android/server/SerialService;

    move-object/from16 v0, v154

    invoke-direct {v0, v5}, Lcom/android/server/SerialService;-><init>(Landroid/content/Context;)V
    :try_end_47
    .catch Ljava/lang/Throwable; {:try_start_47 .. :try_end_47} :catch_26

    .line 801
    .end local v153           #serial:Lcom/android/server/SerialService;
    .local v154, serial:Lcom/android/server/SerialService;
    :try_start_48
    const-string v7, "serial"

    move-object/from16 v0, v154

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_48
    .catch Ljava/lang/Throwable; {:try_start_48 .. :try_end_48} :catch_4d

    move-object/from16 v153, v154

    .line 808
    .end local v154           #serial:Lcom/android/server/SerialService;
    .restart local v153       #serial:Lcom/android/server/SerialService;
    :cond_18
    :goto_31
    const-string v7, "security"

    new-instance v9, Lcom/miui/server/SecurityManagerService;

    invoke-direct {v9, v5}, Lcom/miui/server/SecurityManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    :try_start_49
    const-string v7, "SystemServer"

    const-string v9, "Twilight Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 809
    new-instance v166, Lcom/android/server/TwilightService;

    move-object/from16 v0, v166

    invoke-direct {v0, v5}, Lcom/android/server/TwilightService;-><init>(Landroid/content/Context;)V
    :try_end_49
    .catch Ljava/lang/Throwable; {:try_start_49 .. :try_end_49} :catch_27

    .end local v165           #twilight:Lcom/android/server/TwilightService;
    .local v166, twilight:Lcom/android/server/TwilightService;
    move-object/from16 v165, v166

    .line 815
    .end local v166           #twilight:Lcom/android/server/TwilightService;
    .restart local v165       #twilight:Lcom/android/server/TwilightService;
    :goto_32
    :try_start_4a
    const-string v7, "SystemServer"

    const-string v9, "UI Mode Manager Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 817
    new-instance v168, Lcom/android/server/UiModeManagerService;

    move-object/from16 v0, v168

    move-object/from16 v1, v165

    invoke-direct {v0, v5, v1}, Lcom/android/server/UiModeManagerService;-><init>(Landroid/content/Context;Lcom/android/server/TwilightService;)V
    :try_end_4a
    .catch Ljava/lang/Throwable; {:try_start_4a .. :try_end_4a} :catch_28

    .end local v167           #uiMode:Lcom/android/server/UiModeManagerService;
    .local v168, uiMode:Lcom/android/server/UiModeManagerService;
    move-object/from16 v167, v168

    .line 822
    .end local v168           #uiMode:Lcom/android/server/UiModeManagerService;
    .restart local v167       #uiMode:Lcom/android/server/UiModeManagerService;
    :goto_33
    if-nez v93, :cond_19

    .line 824
    :try_start_4b
    const-string v7, "SystemServer"

    const-string v9, "Backup Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 825
    const-string v7, "backup"

    new-instance v9, Lcom/android/server/BackupManagerService;

    invoke-direct {v9, v5}, Lcom/android/server/BackupManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_4b
    .catch Ljava/lang/Throwable; {:try_start_4b .. :try_end_4b} :catch_29

    .line 832
    :goto_34
    :try_start_4c
    const-string v7, "SystemServer"

    const-string v9, "AppWidget Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 833
    new-instance v69, Lcom/android/server/AppWidgetService;

    move-object/from16 v0, v69

    invoke-direct {v0, v5}, Lcom/android/server/AppWidgetService;-><init>(Landroid/content/Context;)V
    :try_end_4c
    .catch Ljava/lang/Throwable; {:try_start_4c .. :try_end_4c} :catch_2a

    .line 834
    .end local v68           #appWidget:Lcom/android/server/AppWidgetService;
    .local v69, appWidget:Lcom/android/server/AppWidgetService;
    :try_start_4d
    const-string v7, "appwidget"

    move-object/from16 v0, v69

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_4d
    .catch Ljava/lang/Throwable; {:try_start_4d .. :try_end_4d} :catch_4c

    move-object/from16 v68, v69

    .line 840
    .end local v69           #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v68       #appWidget:Lcom/android/server/AppWidgetService;
    :goto_35
    :try_start_4e
    const-string v7, "SystemServer"

    const-string v9, "Recognition Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 841
    new-instance v150, Lcom/android/server/RecognitionManagerService;

    move-object/from16 v0, v150

    invoke-direct {v0, v5}, Lcom/android/server/RecognitionManagerService;-><init>(Landroid/content/Context;)V
    :try_end_4e
    .catch Ljava/lang/Throwable; {:try_start_4e .. :try_end_4e} :catch_2b

    .end local v149           #recognition:Lcom/android/server/RecognitionManagerService;
    .local v150, recognition:Lcom/android/server/RecognitionManagerService;
    move-object/from16 v149, v150

    .line 848
    .end local v150           #recognition:Lcom/android/server/RecognitionManagerService;
    .restart local v149       #recognition:Lcom/android/server/RecognitionManagerService;
    :cond_19
    :goto_36
    :try_start_4f
    const-string v7, "SystemServer"

    const-string v9, "DiskStats Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 849
    const-string v7, "diskstats"

    new-instance v9, Lcom/android/server/DiskStatsService;

    invoke-direct {v9, v5}, Lcom/android/server/DiskStatsService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_4f
    .catch Ljava/lang/Throwable; {:try_start_4f .. :try_end_4f} :catch_2c

    .line 859
    :goto_37
    :try_start_50
    const-string v7, "SystemServer"

    const-string v9, "SamplingProfiler Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 860
    const-string v7, "samplingprofiler"

    new-instance v9, Lcom/android/server/SamplingProfilerService;

    invoke-direct {v9, v5}, Lcom/android/server/SamplingProfilerService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_50
    .catch Ljava/lang/Throwable; {:try_start_50 .. :try_end_50} :catch_2d

    .line 866
    :goto_38
    if-nez v92, :cond_1a

    .line 868
    :try_start_51
    const-string v7, "SystemServer"

    const-string v9, "NetworkTimeUpdateService"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 869
    new-instance v133, Lcom/android/server/NetworkTimeUpdateService;

    move-object/from16 v0, v133

    invoke-direct {v0, v5}, Lcom/android/server/NetworkTimeUpdateService;-><init>(Landroid/content/Context;)V
    :try_end_51
    .catch Ljava/lang/Throwable; {:try_start_51 .. :try_end_51} :catch_2e

    .end local v132           #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .local v133, networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    move-object/from16 v132, v133

    .line 875
    .end local v133           #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .restart local v132       #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    :cond_1a
    :goto_39
    if-nez v91, :cond_1b

    .line 877
    :try_start_52
    const-string v7, "SystemServer"

    const-string v9, "CommonTimeManagementService"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 878
    new-instance v77, Lcom/android/server/CommonTimeManagementService;

    move-object/from16 v0, v77

    invoke-direct {v0, v5}, Lcom/android/server/CommonTimeManagementService;-><init>(Landroid/content/Context;)V
    :try_end_52
    .catch Ljava/lang/Throwable; {:try_start_52 .. :try_end_52} :catch_2f

    .line 879
    .end local v76           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .local v77, commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    :try_start_53
    const-string v7, "commontime_management"

    move-object/from16 v0, v77

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_53
    .catch Ljava/lang/Throwable; {:try_start_53 .. :try_end_53} :catch_4b

    move-object/from16 v76, v77

    .line 885
    .end local v77           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v76       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    :cond_1b
    :goto_3a
    if-nez v92, :cond_1c

    .line 887
    :try_start_54
    const-string v7, "SystemServer"

    const-string v9, "CertBlacklister"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 888
    new-instance v7, Lcom/android/server/CertBlacklister;

    invoke-direct {v7, v5}, Lcom/android/server/CertBlacklister;-><init>(Landroid/content/Context;)V
    :try_end_54
    .catch Ljava/lang/Throwable; {:try_start_54 .. :try_end_54} :catch_30

    .line 894
    :cond_1c
    :goto_3b
    if-nez v93, :cond_1d

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v9, 0x1110053

    invoke-virtual {v7, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v7

    if-eqz v7, :cond_1d

    .line 897
    :try_start_55
    const-string v7, "SystemServer"

    const-string v9, "Dreams Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 899
    new-instance v101, Lcom/android/server/dreams/DreamManagerService;

    move-object/from16 v0, v101

    move-object/from16 v1, v21

    invoke-direct {v0, v5, v1}, Lcom/android/server/dreams/DreamManagerService;-><init>(Landroid/content/Context;Landroid/os/Handler;)V
    :try_end_55
    .catch Ljava/lang/Throwable; {:try_start_55 .. :try_end_55} :catch_31

    .line 900
    .end local v100           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .local v101, dreamy:Lcom/android/server/dreams/DreamManagerService;
    :try_start_56
    const-string v7, "dreams"

    move-object/from16 v0, v101

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_56
    .catch Ljava/lang/Throwable; {:try_start_56 .. :try_end_56} :catch_4a

    move-object/from16 v100, v101

    .line 906
    .end local v101           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .restart local v100       #dreamy:Lcom/android/server/dreams/DreamManagerService;
    :cond_1d
    :goto_3c
    if-nez v93, :cond_1e

    .line 908
    :try_start_57
    const-string v7, "SystemServer"

    const-string v9, "Assets Atlas Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 909
    new-instance v71, Lcom/android/server/AssetAtlasService;

    move-object/from16 v0, v71

    invoke-direct {v0, v5}, Lcom/android/server/AssetAtlasService;-><init>(Landroid/content/Context;)V
    :try_end_57
    .catch Ljava/lang/Throwable; {:try_start_57 .. :try_end_57} :catch_32

    .line 910
    .end local v70           #atlas:Lcom/android/server/AssetAtlasService;
    .local v71, atlas:Lcom/android/server/AssetAtlasService;
    :try_start_58
    const-string v7, "assetatlas"

    move-object/from16 v0, v71

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_58
    .catch Ljava/lang/Throwable; {:try_start_58 .. :try_end_58} :catch_49

    move-object/from16 v70, v71

    .line 916
    .end local v71           #atlas:Lcom/android/server/AssetAtlasService;
    .restart local v70       #atlas:Lcom/android/server/AssetAtlasService;
    :cond_1e
    :goto_3d
    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v9, 0x111006d

    invoke-virtual {v7, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v7

    if-eqz v7, :cond_1f

    .line 919
    :try_start_59
    const-string v7, "SystemServer"

    const-string v9, "Gesture Sensor Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 920
    new-instance v111, Lcom/android/server/gesture/GestureService;

    move-object/from16 v0, v111

    move-object/from16 v1, v20

    invoke-direct {v0, v5, v1}, Lcom/android/server/gesture/GestureService;-><init>(Landroid/content/Context;Lcom/android/server/input/InputManagerService;)V
    :try_end_59
    .catch Ljava/lang/Throwable; {:try_start_59 .. :try_end_59} :catch_33

    .line 921
    .end local v110           #gestureService:Lcom/android/server/gesture/GestureService;
    .local v111, gestureService:Lcom/android/server/gesture/GestureService;
    :try_start_5a
    const-string v7, "gesture"

    move-object/from16 v0, v111

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_5a
    .catch Ljava/lang/Throwable; {:try_start_5a .. :try_end_5a} :catch_48

    move-object/from16 v110, v111

    .line 928
    .end local v111           #gestureService:Lcom/android/server/gesture/GestureService;
    .restart local v110       #gestureService:Lcom/android/server/gesture/GestureService;
    :cond_1f
    :goto_3e
    :try_start_5b
    const-string v7, "SystemServer"

    const-string v9, "IdleMaintenanceService"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 929
    new-instance v7, Lcom/android/server/IdleMaintenanceService;

    invoke-direct {v7, v5, v8}, Lcom/android/server/IdleMaintenanceService;-><init>(Landroid/content/Context;Lcom/android/server/BatteryService;)V
    :try_end_5b
    .catch Ljava/lang/Throwable; {:try_start_5b .. :try_end_5b} :catch_34

    .line 935
    :goto_3f
    :try_start_5c
    const-string v7, "SystemServer"

    const-string v9, "Print Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 936
    new-instance v140, Lcom/android/server/print/PrintManagerService;

    move-object/from16 v0, v140

    invoke-direct {v0, v5}, Lcom/android/server/print/PrintManagerService;-><init>(Landroid/content/Context;)V
    :try_end_5c
    .catch Ljava/lang/Throwable; {:try_start_5c .. :try_end_5c} :catch_35

    .line 937
    .end local v139           #printManager:Lcom/android/server/print/PrintManagerService;
    .local v140, printManager:Lcom/android/server/print/PrintManagerService;
    :try_start_5d
    const-string v7, "print"

    move-object/from16 v0, v140

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_5d
    .catch Ljava/lang/Throwable; {:try_start_5d .. :try_end_5d} :catch_47

    move-object/from16 v139, v140

    .line 943
    .end local v140           #printManager:Lcom/android/server/print/PrintManagerService;
    .restart local v139       #printManager:Lcom/android/server/print/PrintManagerService;
    :goto_40
    :try_start_5e
    const-string v7, "SystemServer"

    const-string v9, "Theme Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 944
    new-instance v162, Lcom/android/server/ThemeService;

    move-object/from16 v0, v162

    invoke-direct {v0, v5}, Lcom/android/server/ThemeService;-><init>(Landroid/content/Context;)V
    :try_end_5e
    .catch Ljava/lang/Throwable; {:try_start_5e .. :try_end_5e} :catch_36

    .line 945
    .end local v161           #themeService:Lcom/android/server/ThemeService;
    .local v162, themeService:Lcom/android/server/ThemeService;
    :try_start_5f
    const-string v7, "themes"

    move-object/from16 v0, v162

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_5f
    .catch Ljava/lang/Throwable; {:try_start_5f .. :try_end_5f} :catch_46

    move-object/from16 v161, v162

    .line 949
    .end local v162           #themeService:Lcom/android/server/ThemeService;
    .restart local v161       #themeService:Lcom/android/server/ThemeService;
    :goto_41
    if-nez v93, :cond_20

    .line 951
    :try_start_60
    const-string v7, "SystemServer"

    const-string v9, "Media Router Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 952
    new-instance v124, Lcom/android/server/media/MediaRouterService;

    move-object/from16 v0, v124

    invoke-direct {v0, v5}, Lcom/android/server/media/MediaRouterService;-><init>(Landroid/content/Context;)V
    :try_end_60
    .catch Ljava/lang/Throwable; {:try_start_60 .. :try_end_60} :catch_37

    .line 953
    .end local v123           #mediaRouter:Lcom/android/server/media/MediaRouterService;
    .local v124, mediaRouter:Lcom/android/server/media/MediaRouterService;
    :try_start_61
    const-string v7, "media_router"

    move-object/from16 v0, v124

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_61
    .catch Ljava/lang/Throwable; {:try_start_61 .. :try_end_61} :catch_45

    move-object/from16 v123, v124

    .line 961
    .end local v124           #mediaRouter:Lcom/android/server/media/MediaRouterService;
    .restart local v123       #mediaRouter:Lcom/android/server/media/MediaRouterService;
    :cond_20
    :goto_42
    :try_start_62
    const-string v7, "SystemServer"

    const-string v9, "EdgeGesture service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 962
    new-instance v104, Lcom/android/server/gesture/EdgeGestureService;

    move-object/from16 v0, v104

    move-object/from16 v1, v20

    invoke-direct {v0, v5, v1}, Lcom/android/server/gesture/EdgeGestureService;-><init>(Landroid/content/Context;Lcom/android/server/input/InputManagerService;)V
    :try_end_62
    .catch Ljava/lang/Throwable; {:try_start_62 .. :try_end_62} :catch_38

    .line 963
    .end local v103           #edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    .local v104, edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    :try_start_63
    const-string v7, "edgegestureservice"

    move-object/from16 v0, v104

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_63
    .catch Ljava/lang/Throwable; {:try_start_63 .. :try_end_63} :catch_44

    move-object/from16 v103, v104

    .line 970
    .end local v104           #edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    .restart local v103       #edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    :goto_43
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/server/ServerThread;->mContentResolver:Landroid/content/ContentResolver;

    const-string v9, "adb_port"

    const-string v10, "service.adb.tcp.port"

    const-string v12, "-1"

    invoke-static {v10, v12}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v10

    invoke-static {v7, v9, v10}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 974
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/server/ServerThread;->mContentResolver:Landroid/content/ContentResolver;

    const-string v9, "adb_port"

    invoke-static {v9}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v9

    const/4 v10, 0x0

    new-instance v12, Lcom/android/server/ServerThread$AdbPortObserver;

    move-object/from16 v0, p0

    invoke-direct {v12, v0}, Lcom/android/server/ServerThread$AdbPortObserver;-><init>(Lcom/android/server/ServerThread;)V

    invoke-virtual {v7, v9, v10, v12}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 977
    const v7, 0x10400e6

    invoke-virtual {v5, v7}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_21

    .line 979
    new-instance v136, Lcom/android/server/ServerThread$PerformanceProfileObserver;

    move-object/from16 v0, v136

    move-object/from16 v1, p0

    invoke-direct {v0, v1, v5}, Lcom/android/server/ServerThread$PerformanceProfileObserver;-><init>(Lcom/android/server/ServerThread;Landroid/content/Context;)V

    .line 980
    .local v136, observer:Lcom/android/server/ServerThread$PerformanceProfileObserver;
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/server/ServerThread;->mContentResolver:Landroid/content/ContentResolver;

    const-string v9, "performance_profile"

    invoke-static {v9}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v9

    const/4 v10, 0x0

    move-object/from16 v0, v136

    invoke-virtual {v7, v9, v10, v0}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 985
    invoke-virtual/range {v136 .. v136}, Lcom/android/server/ServerThread$PerformanceProfileObserver;->setSystemSetting()V

    .line 990
    .end local v136           #observer:Lcom/android/server/ServerThread$PerformanceProfileObserver;
    :cond_21
    invoke-virtual/range {v180 .. v180}, Lcom/android/server/wm/WindowManagerService;->detectSafeMode()Z

    move-result v48

    .line 991
    .local v48, safeMode:Z
    if-eqz v48, :cond_37

    .line 992
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v7

    invoke-virtual {v7}, Lcom/android/server/am/ActivityManagerService;->enterSafeMode()V

    .line 994
    const/4 v7, 0x1

    sput-boolean v7, Ldalvik/system/Zygote;->systemInSafeMode:Z

    .line 996
    invoke-static {}, Ldalvik/system/VMRuntime;->getRuntime()Ldalvik/system/VMRuntime;

    move-result-object v7

    invoke-virtual {v7}, Ldalvik/system/VMRuntime;->disableJitCompilation()V

    .line 1005
    :goto_44
    :try_start_64
    invoke-virtual/range {v171 .. v171}, Lcom/android/server/VibratorService;->systemReady()V
    :try_end_64
    .catch Ljava/lang/Throwable; {:try_start_64 .. :try_end_64} :catch_39

    .line 1010
    :goto_45
    if-eqz v121, :cond_22

    .line 1012
    :try_start_65
    invoke-virtual/range {v121 .. v121}, Lcom/android/server/LockSettingsService;->systemReady()V
    :try_end_65
    .catch Ljava/lang/Throwable; {:try_start_65 .. :try_end_65} :catch_3a

    .line 1018
    :cond_22
    :goto_46
    if-eqz v87, :cond_23

    .line 1020
    :try_start_66
    invoke-virtual/range {v87 .. v87}, Lcom/android/server/DevicePolicyManagerService;->systemReady()V
    :try_end_66
    .catch Ljava/lang/Throwable; {:try_start_66 .. :try_end_66} :catch_3b

    .line 1026
    :cond_23
    :goto_47
    if-eqz v134, :cond_24

    .line 1028
    :try_start_67
    invoke-virtual/range {v134 .. v134}, Lcom/android/server/NotificationManagerService;->systemReady()V
    :try_end_67
    .catch Ljava/lang/Throwable; {:try_start_67 .. :try_end_67} :catch_3c

    .line 1035
    :cond_24
    :goto_48
    :try_start_68
    invoke-virtual/range {v180 .. v180}, Lcom/android/server/wm/WindowManagerService;->systemReady()V
    :try_end_68
    .catch Ljava/lang/Throwable; {:try_start_68 .. :try_end_68} :catch_3d

    .line 1040
    :goto_49
    if-eqz v48, :cond_25

    .line 1041
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v7

    invoke-virtual {v7}, Lcom/android/server/am/ActivityManagerService;->showSafeModeOverlay()V

    .line 1047
    :cond_25
    invoke-virtual/range {v180 .. v180}, Lcom/android/server/wm/WindowManagerService;->computeNewConfiguration()Landroid/content/res/Configuration;

    move-result-object v78

    .line 1048
    .local v78, config:Landroid/content/res/Configuration;
    new-instance v125, Landroid/util/DisplayMetrics;

    invoke-direct/range {v125 .. v125}, Landroid/util/DisplayMetrics;-><init>()V

    .line 1049
    .local v125, metrics:Landroid/util/DisplayMetrics;
    const-string v7, "window"

    invoke-virtual {v5, v7}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v173

    check-cast v173, Landroid/view/WindowManager;

    .line 1050
    .local v173, w:Landroid/view/WindowManager;
    invoke-interface/range {v173 .. v173}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v7

    move-object/from16 v0, v125

    invoke-virtual {v7, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 1051
    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    move-object/from16 v0, v78

    move-object/from16 v1, v125

    invoke-virtual {v7, v0, v1}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V

    .line 1054
    :try_start_69
    move-object/from16 v0, v165

    move-object/from16 v1, v100

    invoke-virtual {v4, v0, v1}, Lcom/android/server/power/PowerManagerService;->systemReady(Lcom/android/server/TwilightService;Lcom/android/server/dreams/DreamManagerService;)V
    :try_end_69
    .catch Ljava/lang/Throwable; {:try_start_69 .. :try_end_69} :catch_3e

    .line 1060
    :goto_4a
    :try_start_6a
    invoke-interface/range {v137 .. v137}, Landroid/content/pm/IPackageManager;->systemReady()V
    :try_end_6a
    .catch Ljava/lang/Throwable; {:try_start_6a .. :try_end_6a} :catch_3f

    .line 1066
    :goto_4b
    :try_start_6b
    move/from16 v0, v48

    move/from16 v1, v24

    invoke-virtual {v11, v0, v1}, Lcom/android/server/display/DisplayManagerService;->systemReady(ZZ)V
    :try_end_6b
    .catch Ljava/lang/Throwable; {:try_start_6b .. :try_end_6b} :catch_40

    .line 1071
    :goto_4c
    if-eqz v110, :cond_26

    .line 1073
    :try_start_6c
    invoke-virtual/range {v110 .. v110}, Lcom/android/server/gesture/GestureService;->systemReady()V
    :try_end_6c
    .catch Ljava/lang/Throwable; {:try_start_6c .. :try_end_6c} :catch_41

    .line 1079
    :cond_26
    :goto_4d
    if-eqz v103, :cond_27

    .line 1081
    :try_start_6d
    invoke-virtual/range {v103 .. v103}, Lcom/android/server/gesture/EdgeGestureService;->systemReady()V
    :try_end_6d
    .catch Ljava/lang/Throwable; {:try_start_6d .. :try_end_6d} :catch_42

    .line 1087
    :cond_27
    :goto_4e
    new-instance v108, Landroid/content/IntentFilter;

    invoke-direct/range {v108 .. v108}, Landroid/content/IntentFilter;-><init>()V

    .line 1088
    .local v108, filter:Landroid/content/IntentFilter;
    const-string v7, "com.tmobile.intent.action.APP_LAUNCH_FAILURE"

    move-object/from16 v0, v108

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1089
    const-string v7, "com.tmobile.intent.action.APP_LAUNCH_FAILURE_RESET"

    move-object/from16 v0, v108

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1090
    const-string v7, "android.intent.action.PACKAGE_ADDED"

    move-object/from16 v0, v108

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1091
    const-string v7, "android.intent.action.PACKAGE_REMOVED"

    move-object/from16 v0, v108

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1092
    const-string v7, "org.cyanogenmod.intent.action.THEME_CHANGED"

    move-object/from16 v0, v108

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 1093
    const-string v7, "com.tmobile.intent.category.THEME_PACKAGE_INSTALL_STATE_CHANGE"

    move-object/from16 v0, v108

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    .line 1094
    const-string v7, "package"

    move-object/from16 v0, v108

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addDataScheme(Ljava/lang/String;)V

    .line 1095
    new-instance v7, Lcom/android/server/AppsLaunchFailureReceiver;

    invoke-direct {v7}, Lcom/android/server/AppsLaunchFailureReceiver;-><init>()V

    move-object/from16 v0, v108

    invoke-virtual {v5, v7, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 1098
    move-object/from16 v34, v5

    .line 1099
    .local v34, contextF:Landroid/content/Context;
    move-object/from16 v35, v126

    .line 1100
    .local v35, mountServiceF:Lcom/android/server/MountService;
    move-object/from16 v36, v8

    .line 1101
    .local v36, batteryF:Lcom/android/server/BatteryService;
    move-object/from16 v37, v30

    .line 1102
    .local v37, networkManagementF:Lcom/android/server/NetworkManagementService;
    move-object/from16 v38, v29

    .line 1103
    .local v38, networkStatsF:Lcom/android/server/net/NetworkStatsService;
    move-object/from16 v39, v25

    .line 1104
    .local v39, networkPolicyF:Lcom/android/server/net/NetworkPolicyManagerService;
    move-object/from16 v40, v79

    .line 1105
    .local v40, connectivityF:Lcom/android/server/ConnectivityService;
    move-object/from16 v41, v98

    .line 1106
    .local v41, dockF:Lcom/android/server/DockObserver;
    move-object/from16 v42, v151

    .line 1107
    .local v42, rotateSwitchF:Lcom/android/server/RotationSwitchObserver;
    move-object/from16 v43, v169

    .line 1108
    .local v43, usbF:Lcom/android/server/usb/UsbService;
    move-object/from16 v44, v165

    .line 1109
    .local v44, twilightF:Lcom/android/server/TwilightService;
    move-object/from16 v45, v167

    .line 1110
    .local v45, uiModeF:Lcom/android/server/UiModeManagerService;
    move-object/from16 v47, v68

    .line 1111
    .local v47, appWidgetF:Lcom/android/server/AppWidgetService;
    move-object/from16 v49, v174

    .line 1112
    .local v49, wallpaperF:Lcom/android/server/WallpaperManagerService;
    move-object/from16 v50, v113

    .line 1113
    .local v50, immF:Lcom/android/server/InputMethodManagerService;
    move-object/from16 v46, v149

    .line 1114
    .local v46, recognitionF:Lcom/android/server/RecognitionManagerService;
    move-object/from16 v52, v119

    .line 1115
    .local v52, locationF:Lcom/android/server/LocationManagerService;
    move-object/from16 v53, v84

    .line 1116
    .local v53, countryDetectorF:Lcom/android/server/CountryDetectorService;
    move-object/from16 v54, v132

    .line 1117
    .local v54, networkTimeUpdaterF:Lcom/android/server/NetworkTimeUpdateService;
    move-object/from16 v55, v76

    .line 1118
    .local v55, commonTimeMgmtServiceF:Lcom/android/server/CommonTimeManagementService;
    move-object/from16 v56, v163

    .line 1119
    .local v56, textServiceManagerServiceF:Lcom/android/server/TextServicesManagerService;
    move-object/from16 v51, v157

    .line 1120
    .local v51, statusBarF:Lcom/android/server/StatusBarManagerService;
    move-object/from16 v57, v100

    .line 1121
    .local v57, dreamyF:Lcom/android/server/dreams/DreamManagerService;
    move-object/from16 v58, v70

    .line 1122
    .local v58, atlasF:Lcom/android/server/AssetAtlasService;
    move-object/from16 v59, v20

    .line 1123
    .local v59, inputManagerF:Lcom/android/server/input/InputManagerService;
    move-object/from16 v60, v159

    .line 1124
    .local v60, telephonyRegistryF:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v61, v128

    .line 1125
    .local v61, msimTelephonyRegistryF:Lcom/android/server/MSimTelephonyRegistry;
    move-object/from16 v62, v139

    .line 1126
    .local v62, printManagerF:Lcom/android/server/print/PrintManagerService;
    move-object/from16 v63, v123

    .line 1127
    .local v63, mediaRouterF:Lcom/android/server/media/MediaRouterService;
    move-object/from16 v64, v137

    .line 1134
    .local v64, pmf:Landroid/content/pm/IPackageManager;
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v7

    new-instance v31, Lcom/android/server/ServerThread$2;

    move-object/from16 v32, p0

    invoke-direct/range {v31 .. v64}, Lcom/android/server/ServerThread$2;-><init>(Lcom/android/server/ServerThread;ZLandroid/content/Context;Lcom/android/server/MountService;Lcom/android/server/BatteryService;Lcom/android/server/NetworkManagementService;Lcom/android/server/net/NetworkStatsService;Lcom/android/server/net/NetworkPolicyManagerService;Lcom/android/server/ConnectivityService;Lcom/android/server/DockObserver;Lcom/android/server/RotationSwitchObserver;Lcom/android/server/usb/UsbService;Lcom/android/server/TwilightService;Lcom/android/server/UiModeManagerService;Lcom/android/server/RecognitionManagerService;Lcom/android/server/AppWidgetService;ZLcom/android/server/WallpaperManagerService;Lcom/android/server/InputMethodManagerService;Lcom/android/server/StatusBarManagerService;Lcom/android/server/LocationManagerService;Lcom/android/server/CountryDetectorService;Lcom/android/server/NetworkTimeUpdateService;Lcom/android/server/CommonTimeManagementService;Lcom/android/server/TextServicesManagerService;Lcom/android/server/dreams/DreamManagerService;Lcom/android/server/AssetAtlasService;Lcom/android/server/input/InputManagerService;Lcom/android/server/TelephonyRegistry;Lcom/android/server/MSimTelephonyRegistry;Lcom/android/server/print/PrintManagerService;Lcom/android/server/media/MediaRouterService;Landroid/content/pm/IPackageManager;)V

    move-object/from16 v0, v31

    invoke-virtual {v7, v0}, Lcom/android/server/am/ActivityManagerService;->systemReady(Ljava/lang/Runnable;)V

    .line 1305
    invoke-static {}, Landroid/os/StrictMode;->conditionallyEnableDebugLogging()Z

    move-result v7

    if-eqz v7, :cond_28

    .line 1306
    const-string v7, "SystemServer"

    const-string v9, "Enabled StrictMode for system server main thread."

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1309
    :cond_28
    invoke-static {}, Landroid/os/Looper;->loop()V

    .line 1310
    const-string v7, "SystemServer"

    const-string v9, "System ServerThread is exiting!"

    invoke-static {v7, v9}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1311
    return-void

    .line 167
    .end local v4           #power:Lcom/android/server/power/PowerManagerService;
    .end local v5           #context:Landroid/content/Context;
    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v11           #display:Lcom/android/server/display/DisplayManagerService;
    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v21           #wmHandler:Landroid/os/Handler;
    .end local v24           #onlyCore:Z
    .end local v25           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v29           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .end local v30           #networkManagement:Lcom/android/server/NetworkManagementService;
    .end local v33           #headless:Z
    .end local v34           #contextF:Landroid/content/Context;
    .end local v35           #mountServiceF:Lcom/android/server/MountService;
    .end local v36           #batteryF:Lcom/android/server/BatteryService;
    .end local v37           #networkManagementF:Lcom/android/server/NetworkManagementService;
    .end local v38           #networkStatsF:Lcom/android/server/net/NetworkStatsService;
    .end local v39           #networkPolicyF:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v40           #connectivityF:Lcom/android/server/ConnectivityService;
    .end local v41           #dockF:Lcom/android/server/DockObserver;
    .end local v42           #rotateSwitchF:Lcom/android/server/RotationSwitchObserver;
    .end local v43           #usbF:Lcom/android/server/usb/UsbService;
    .end local v44           #twilightF:Lcom/android/server/TwilightService;
    .end local v45           #uiModeF:Lcom/android/server/UiModeManagerService;
    .end local v46           #recognitionF:Lcom/android/server/RecognitionManagerService;
    .end local v47           #appWidgetF:Lcom/android/server/AppWidgetService;
    .end local v48           #safeMode:Z
    .end local v49           #wallpaperF:Lcom/android/server/WallpaperManagerService;
    .end local v50           #immF:Lcom/android/server/InputMethodManagerService;
    .end local v51           #statusBarF:Lcom/android/server/StatusBarManagerService;
    .end local v52           #locationF:Lcom/android/server/LocationManagerService;
    .end local v53           #countryDetectorF:Lcom/android/server/CountryDetectorService;
    .end local v54           #networkTimeUpdaterF:Lcom/android/server/NetworkTimeUpdateService;
    .end local v55           #commonTimeMgmtServiceF:Lcom/android/server/CommonTimeManagementService;
    .end local v56           #textServiceManagerServiceF:Lcom/android/server/TextServicesManagerService;
    .end local v57           #dreamyF:Lcom/android/server/dreams/DreamManagerService;
    .end local v58           #atlasF:Lcom/android/server/AssetAtlasService;
    .end local v59           #inputManagerF:Lcom/android/server/input/InputManagerService;
    .end local v60           #telephonyRegistryF:Lcom/android/server/TelephonyRegistry;
    .end local v61           #msimTelephonyRegistryF:Lcom/android/server/MSimTelephonyRegistry;
    .end local v62           #printManagerF:Lcom/android/server/print/PrintManagerService;
    .end local v63           #mediaRouterF:Lcom/android/server/media/MediaRouterService;
    .end local v64           #pmf:Landroid/content/pm/IPackageManager;
    .end local v65           #accountManager:Lcom/android/server/accounts/AccountManagerService;
    .end local v68           #appWidget:Lcom/android/server/AppWidgetService;
    .end local v70           #atlas:Lcom/android/server/AssetAtlasService;
    .end local v73           #bluetooth:Lcom/android/server/BluetoothManagerService;
    .end local v76           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .end local v78           #config:Landroid/content/res/Configuration;
    .end local v79           #connectivity:Lcom/android/server/ConnectivityService;
    .end local v81           #consumerIr:Lcom/android/server/ConsumerIrService;
    .end local v83           #contentService:Lcom/android/server/content/ContentService;
    .end local v84           #countryDetector:Lcom/android/server/CountryDetectorService;
    .end local v87           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .end local v89           #disableBluetooth:Z
    .end local v90           #disableLocation:Z
    .end local v91           #disableMedia:Z
    .end local v92           #disableNetwork:Z
    .end local v93           #disableNonCoreServices:Z
    .end local v94           #disableStorage:Z
    .end local v95           #disableSystemUI:Z
    .end local v96           #disableTelephony:Z
    .end local v98           #dock:Lcom/android/server/DockObserver;
    .end local v100           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .end local v103           #edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    .end local v106           #factoryTest:I
    .end local v107           #factoryTestStr:Ljava/lang/String;
    .end local v108           #filter:Landroid/content/IntentFilter;
    .end local v109           #firstBoot:Z
    .end local v110           #gestureService:Lcom/android/server/gesture/GestureService;
    .end local v112           #hasRotationLock:Z
    .end local v113           #imm:Lcom/android/server/InputMethodManagerService;
    .end local v116           #installer:Lcom/android/server/pm/Installer;
    .end local v119           #location:Lcom/android/server/LocationManagerService;
    .end local v121           #lockSettings:Lcom/android/server/LockSettingsService;
    .end local v123           #mediaRouter:Lcom/android/server/media/MediaRouterService;
    .end local v125           #metrics:Landroid/util/DisplayMetrics;
    .end local v126           #mountService:Lcom/android/server/MountService;
    .end local v128           #msimTelephonyRegistry:Lcom/android/server/MSimTelephonyRegistry;
    .end local v132           #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .end local v134           #notification:Lcom/android/server/NotificationManagerService;
    .end local v137           #pm:Landroid/content/pm/IPackageManager;
    .end local v139           #printManager:Lcom/android/server/print/PrintManagerService;
    .end local v141           #profile:Lcom/android/server/ProfileManagerService;
    .end local v149           #recognition:Lcom/android/server/RecognitionManagerService;
    .end local v151           #rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    .end local v153           #serial:Lcom/android/server/SerialService;
    .end local v155           #serviceDiscovery:Lcom/android/server/NsdService;
    .end local v157           #statusBar:Lcom/android/server/StatusBarManagerService;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v161           #themeService:Lcom/android/server/ThemeService;
    .end local v163           #tsms:Lcom/android/server/TextServicesManagerService;
    .end local v165           #twilight:Lcom/android/server/TwilightService;
    .end local v167           #uiMode:Lcom/android/server/UiModeManagerService;
    .end local v169           #usb:Lcom/android/server/usb/UsbService;
    .end local v171           #vibrator:Lcom/android/server/VibratorService;
    .end local v173           #w:Landroid/view/WindowManager;
    .end local v174           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .end local v176           #wifi:Lcom/android/server/wifi/WifiService;
    .end local v178           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .end local v180           #wm:Lcom/android/server/wm/WindowManagerService;
    .end local v181           #wmHandlerThread:Landroid/os/HandlerThread;
    :cond_29
    const/16 v148, 0x0

    goto/16 :goto_0

    .line 173
    .restart local v148       #reboot:Z
    :cond_2a
    const/16 v147, 0x0

    .restart local v147       #reason:Ljava/lang/String;
    goto/16 :goto_1

    .line 181
    .end local v147           #reason:Ljava/lang/String;
    .end local v148           #reboot:Z
    .restart local v107       #factoryTestStr:Ljava/lang/String;
    :cond_2b
    invoke-static/range {v107 .. v107}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v106

    goto/16 :goto_2

    .line 258
    .restart local v4       #power:Lcom/android/server/power/PowerManagerService;
    .restart local v5       #context:Landroid/content/Context;
    .restart local v21       #wmHandler:Landroid/os/Handler;
    .restart local v24       #onlyCore:Z
    .restart local v29       #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v30       #networkManagement:Lcom/android/server/NetworkManagementService;
    .restart local v33       #headless:Z
    .restart local v65       #accountManager:Lcom/android/server/accounts/AccountManagerService;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #battery:Lcom/android/server/BatteryService;
    .restart local v73       #bluetooth:Lcom/android/server/BluetoothManagerService;
    .restart local v76       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v79       #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v81       #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v83       #contentService:Lcom/android/server/content/ContentService;
    .restart local v97       #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v98       #dock:Lcom/android/server/DockObserver;
    .restart local v106       #factoryTest:I
    .restart local v109       #firstBoot:Z
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v116       #installer:Lcom/android/server/pm/Installer;
    .restart local v118       #lights:Lcom/android/server/LightsService;
    .restart local v126       #mountService:Lcom/android/server/MountService;
    .restart local v128       #msimTelephonyRegistry:Lcom/android/server/MSimTelephonyRegistry;
    .restart local v130       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v132       #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .restart local v137       #pm:Landroid/content/pm/IPackageManager;
    .restart local v143       #qcCon:Ljava/lang/Object;
    .restart local v149       #recognition:Lcom/android/server/RecognitionManagerService;
    .restart local v151       #rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    .restart local v153       #serial:Lcom/android/server/SerialService;
    .restart local v155       #serviceDiscovery:Lcom/android/server/NsdService;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v165       #twilight:Lcom/android/server/TwilightService;
    .restart local v167       #uiMode:Lcom/android/server/UiModeManagerService;
    .restart local v169       #usb:Lcom/android/server/usb/UsbService;
    .restart local v171       #vibrator:Lcom/android/server/VibratorService;
    .restart local v176       #wifi:Lcom/android/server/wifi/WifiService;
    .restart local v178       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v180       #wm:Lcom/android/server/wm/WindowManagerService;
    .restart local v181       #wmHandlerThread:Landroid/os/HandlerThread;
    :catch_0
    move-exception v102

    .line 259
    .local v102, e:Ljava/lang/RuntimeException;
    :goto_4f
    const-string v7, "System"

    const-string v9, "******************************************"

    invoke-static {v7, v9}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 260
    const-string v7, "System"

    const-string v9, "************ Failure starting bootstrap service"

    move-object/from16 v0, v102

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_3

    .line 303
    .end local v97           #display:Lcom/android/server/display/DisplayManagerService;
    .end local v102           #e:Ljava/lang/RuntimeException;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v11       #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v86       #cryptState:Ljava/lang/String;
    .restart local v89       #disableBluetooth:Z
    .restart local v90       #disableLocation:Z
    .restart local v91       #disableMedia:Z
    .restart local v92       #disableNetwork:Z
    .restart local v93       #disableNonCoreServices:Z
    .restart local v94       #disableStorage:Z
    .restart local v95       #disableSystemUI:Z
    .restart local v96       #disableTelephony:Z
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :cond_2c
    :try_start_6e
    const-string v7, "1"

    move-object/from16 v0, v86

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_3

    .line 304
    const-string v7, "SystemServer"

    const-string v9, "Device encrypted - only parsing core apps"

    invoke-static {v7, v9}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 305
    const/16 v24, 0x1

    goto/16 :goto_4

    .line 308
    :cond_2d
    const/4 v7, 0x0

    goto/16 :goto_5

    .line 333
    :catch_1
    move-exception v102

    .line 334
    .local v102, e:Ljava/lang/Throwable;
    :goto_50
    const-string v7, "SystemServer"

    const-string v9, "Failure starting Account Manager"

    move-object/from16 v0, v102

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_6e
    .catch Ljava/lang/RuntimeException; {:try_start_6e .. :try_end_6e} :catch_2

    goto/16 :goto_7

    .line 409
    .end local v86           #cryptState:Ljava/lang/String;
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_2
    move-exception v102

    move-object/from16 v159, v160

    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v20, v115

    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v16, v67

    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v72

    .end local v72           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v6, v118

    .line 410
    .end local v118           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    .local v102, e:Ljava/lang/RuntimeException;
    :goto_51
    const-string v7, "System"

    const-string v9, "******************************************"

    invoke-static {v7, v9}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 411
    const-string v7, "System"

    const-string v9, "************ Failure starting core service"

    move-object/from16 v0, v102

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_c

    .line 338
    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v102           #e:Ljava/lang/RuntimeException;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #battery:Lcom/android/server/BatteryService;
    .restart local v86       #cryptState:Ljava/lang/String;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v118       #lights:Lcom/android/server/LightsService;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :cond_2e
    const/4 v7, 0x0

    goto/16 :goto_8

    .line 378
    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v72           #battery:Lcom/android/server/BatteryService;
    .end local v81           #consumerIr:Lcom/android/server/ConsumerIrService;
    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v118           #lights:Lcom/android/server/LightsService;
    .end local v171           #vibrator:Lcom/android/server/VibratorService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v82       #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v172       #vibrator:Lcom/android/server/VibratorService;
    :cond_2f
    const/16 v22, 0x0

    goto/16 :goto_9

    :cond_30
    const/16 v23, 0x0

    goto/16 :goto_a

    .line 397
    :cond_31
    const/4 v7, 0x1

    move/from16 v0, v106

    if-ne v0, v7, :cond_32

    .line 398
    :try_start_6f
    const-string v7, "SystemServer"

    const-string v9, "No Bluetooth Service (factory test)"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_b

    .line 409
    :catch_3
    move-exception v102

    move-object/from16 v81, v82

    .end local v82           #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v81       #consumerIr:Lcom/android/server/ConsumerIrService;
    move-object/from16 v159, v160

    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v171, v172

    .end local v172           #vibrator:Lcom/android/server/VibratorService;
    .restart local v171       #vibrator:Lcom/android/server/VibratorService;
    goto :goto_51

    .line 399
    .end local v81           #consumerIr:Lcom/android/server/ConsumerIrService;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v171           #vibrator:Lcom/android/server/VibratorService;
    .restart local v82       #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v172       #vibrator:Lcom/android/server/VibratorService;
    :cond_32
    invoke-virtual {v5}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v7

    const-string v9, "android.hardware.bluetooth"

    invoke-virtual {v7, v9}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_33

    .line 401
    const-string v7, "SystemServer"

    const-string v9, "No Bluetooth Service (Bluetooth Hardware Not Present)"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_b

    .line 402
    :cond_33
    if-eqz v89, :cond_34

    .line 403
    const-string v7, "SystemServer"

    const-string v9, "Bluetooth Service disabled by config"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_b

    .line 405
    :cond_34
    const-string v7, "SystemServer"

    const-string v9, "Bluetooth Manager Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 406
    new-instance v74, Lcom/android/server/BluetoothManagerService;

    move-object/from16 v0, v74

    invoke-direct {v0, v5}, Lcom/android/server/BluetoothManagerService;-><init>(Landroid/content/Context;)V
    :try_end_6f
    .catch Ljava/lang/RuntimeException; {:try_start_6f .. :try_end_6f} :catch_3

    .line 407
    .end local v73           #bluetooth:Lcom/android/server/BluetoothManagerService;
    .local v74, bluetooth:Lcom/android/server/BluetoothManagerService;
    :try_start_70
    const-string v7, "bluetooth_manager"

    move-object/from16 v0, v74

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_70
    .catch Ljava/lang/RuntimeException; {:try_start_70 .. :try_end_70} :catch_68

    move-object/from16 v73, v74

    .end local v74           #bluetooth:Lcom/android/server/BluetoothManagerService;
    .restart local v73       #bluetooth:Lcom/android/server/BluetoothManagerService;
    goto/16 :goto_b

    .line 444
    .end local v82           #consumerIr:Lcom/android/server/ConsumerIrService;
    .end local v86           #cryptState:Ljava/lang/String;
    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v172           #vibrator:Lcom/android/server/VibratorService;
    .restart local v68       #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v70       #atlas:Lcom/android/server/AssetAtlasService;
    .restart local v81       #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v84       #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v87       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v100       #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .restart local v103       #edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    .restart local v110       #gestureService:Lcom/android/server/gesture/GestureService;
    .restart local v112       #hasRotationLock:Z
    .restart local v113       #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v119       #location:Lcom/android/server/LocationManagerService;
    .restart local v121       #lockSettings:Lcom/android/server/LockSettingsService;
    .restart local v123       #mediaRouter:Lcom/android/server/media/MediaRouterService;
    .restart local v134       #notification:Lcom/android/server/NotificationManagerService;
    .restart local v139       #printManager:Lcom/android/server/print/PrintManagerService;
    .restart local v141       #profile:Lcom/android/server/ProfileManagerService;
    .restart local v157       #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v161       #themeService:Lcom/android/server/ThemeService;
    .restart local v163       #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v171       #vibrator:Lcom/android/server/VibratorService;
    .restart local v174       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :catch_4
    move-exception v102

    .line 445
    .local v102, e:Ljava/lang/Throwable;
    :goto_52
    const-string v7, "starting Input Manager Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_d

    .line 452
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_5
    move-exception v102

    .line 453
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting Accessibility Manager"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_e

    .line 460
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_6
    move-exception v102

    .line 461
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making display ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_f

    .line 466
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_7
    move-exception v102

    .line 467
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "performing boot dexopt"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_10

    .line 489
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_8
    move-exception v102

    .line 490
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_53
    const-string v7, "starting Mount Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_12

    .line 499
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_9
    move-exception v102

    .line 500
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_54
    const-string v7, "starting LockSettingsService service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_13

    .line 507
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_a
    move-exception v102

    .line 508
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_55
    const-string v7, "starting DevicePolicyService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_14

    .line 517
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_b
    move-exception v102

    .line 518
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_56
    const-string v7, "starting StatusBarManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_15

    .line 527
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_c
    move-exception v102

    .line 528
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting Clipboard Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_16

    .line 537
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_d
    move-exception v102

    .line 538
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting NetworkManagement Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_17

    .line 547
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_e
    move-exception v102

    .line 548
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_57
    const-string v7, "starting Text Service Manager Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_18

    .line 557
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_f
    move-exception v102

    .line 558
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_58
    const-string v7, "starting NetworkStats Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_19

    .line 567
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_10
    move-exception v102

    move-object/from16 v25, v130

    .line 568
    .end local v130           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v25       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_59
    const-string v7, "starting NetworkPolicy Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1a

    .line 575
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_11
    move-exception v102

    .line 576
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_5a
    const-string v7, "starting Wi-Fi P2pService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1b

    .line 583
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_12
    move-exception v102

    .line 584
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_5b
    const-string v7, "starting Wi-Fi Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1c

    .line 592
    .end local v102           #e:Ljava/lang/Throwable;
    .restart local v105       #enableCne:I
    :cond_35
    const/16 v75, 0x0

    goto/16 :goto_1d

    .line 610
    .restart local v75       #cneFeature:I
    :cond_36
    :try_start_71
    const-string v7, "SystemServer"

    const-string v9, "Connectivity Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 611
    new-instance v80, Lcom/android/server/ConnectivityService;

    move-object/from16 v0, v80

    move-object/from16 v1, v30

    move-object/from16 v2, v29

    move-object/from16 v3, v25

    invoke-direct {v0, v5, v1, v2, v3}, Lcom/android/server/ConnectivityService;-><init>(Landroid/content/Context;Landroid/os/INetworkManagementService;Landroid/net/INetworkStatsService;Landroid/net/INetworkPolicyManager;)V
    :try_end_71
    .catch Ljava/lang/Throwable; {:try_start_71 .. :try_end_71} :catch_13

    .end local v79           #connectivity:Lcom/android/server/ConnectivityService;
    .local v80, connectivity:Lcom/android/server/ConnectivityService;
    move-object/from16 v79, v80

    .end local v80           #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v79       #connectivity:Lcom/android/server/ConnectivityService;
    goto/16 :goto_1e

    .line 614
    .end local v143           #qcCon:Ljava/lang/Object;
    :catch_13
    move-exception v102

    .line 615
    .restart local v102       #e:Ljava/lang/Throwable;
    :try_start_72
    new-instance v80, Lcom/android/server/ConnectivityService;

    move-object/from16 v0, v80

    move-object/from16 v1, v30

    move-object/from16 v2, v29

    move-object/from16 v3, v25

    invoke-direct {v0, v5, v1, v2, v3}, Lcom/android/server/ConnectivityService;-><init>(Landroid/content/Context;Landroid/os/INetworkManagementService;Landroid/net/INetworkStatsService;Landroid/net/INetworkPolicyManager;)V
    :try_end_72
    .catch Ljava/lang/Throwable; {:try_start_72 .. :try_end_72} :catch_14

    .end local v79           #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v80       #connectivity:Lcom/android/server/ConnectivityService;
    move-object/from16 v79, v80

    .end local v80           #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v79       #connectivity:Lcom/android/server/ConnectivityService;
    goto/16 :goto_1e

    .line 626
    .end local v75           #cneFeature:I
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_14
    move-exception v102

    .line 627
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting Connectivity Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1f

    .line 635
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_15
    move-exception v102

    .line 636
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting Service Discovery Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_20

    .line 645
    .end local v102           #e:Ljava/lang/Throwable;
    .end local v105           #enableCne:I
    :catch_16
    move-exception v102

    .line 646
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting UpdateLockService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_21

    .line 662
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_17
    move-exception v102

    .line 663
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making Account Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_22

    .line 669
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_18
    move-exception v102

    .line 670
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making Content Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_23

    .line 677
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_19
    move-exception v102

    .line 678
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_5c
    const-string v7, "SystemServer"

    const-string v9, "Failure starting Profile Manager"

    move-object/from16 v0, v102

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_24

    .line 686
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_1a
    move-exception v102

    .line 687
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_5d
    const-string v7, "starting Notification Manager"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_25

    .line 694
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_1b
    move-exception v102

    .line 695
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting DeviceStorageMonitor service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_26

    .line 703
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_1c
    move-exception v102

    .line 704
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_5e
    const-string v7, "starting Location Manager"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_27

    .line 711
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_1d
    move-exception v102

    .line 712
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_5f
    const-string v7, "starting Country Detector"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_28

    .line 721
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_1e
    move-exception v102

    .line 722
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting Search Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_29

    .line 730
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_1f
    move-exception v102

    .line 731
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting DropBoxManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2a

    .line 742
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_20
    move-exception v102

    .line 743
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_60
    const-string v7, "starting Wallpaper Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2b

    .line 751
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_21
    move-exception v102

    .line 752
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting Audio Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2c

    .line 761
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_22
    move-exception v102

    .line 762
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting DockObserver"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2d

    .line 772
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_23
    move-exception v102

    .line 773
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting WiredAccessoryManager"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2e

    .line 783
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_24
    move-exception v102

    .line 784
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting RotationSwitchObserver"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2f

    .line 793
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_25
    move-exception v102

    .line 794
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_61
    const-string v7, "starting UsbService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_30

    .line 802
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_26
    move-exception v102

    .line 803
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_62
    const-string v7, "SystemServer"

    const-string v9, "Failure starting SerialService"

    move-object/from16 v0, v102

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_31

    .line 810
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_27
    move-exception v102

    .line 811
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting TwilightService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_32

    .line 818
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_28
    move-exception v102

    .line 819
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting UiModeManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_33

    .line 827
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_29
    move-exception v102

    .line 828
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "SystemServer"

    const-string v9, "Failure starting Backup Service"

    move-object/from16 v0, v102

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_34

    .line 835
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_2a
    move-exception v102

    .line 836
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_63
    const-string v7, "starting AppWidget Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_35

    .line 842
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_2b
    move-exception v102

    .line 843
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting Recognition Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_36

    .line 850
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_2c
    move-exception v102

    .line 851
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting DiskStats Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_37

    .line 862
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_2d
    move-exception v102

    .line 863
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting SamplingProfiler Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_38

    .line 870
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_2e
    move-exception v102

    .line 871
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting NetworkTimeUpdate service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_39

    .line 880
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_2f
    move-exception v102

    .line 881
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_64
    const-string v7, "starting CommonTimeManagementService service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3a

    .line 889
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_30
    move-exception v102

    .line 890
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting CertBlacklister"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3b

    .line 901
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_31
    move-exception v102

    .line 902
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_65
    const-string v7, "starting DreamManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3c

    .line 911
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_32
    move-exception v102

    .line 912
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_66
    const-string v7, "starting AssetAtlasService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3d

    .line 922
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_33
    move-exception v102

    .line 923
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_67
    const-string v7, "SystemServer"

    const-string v9, "Failure starting Gesture Sensor Service"

    move-object/from16 v0, v102

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_3e

    .line 930
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_34
    move-exception v102

    .line 931
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "starting IdleMaintenanceService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3f

    .line 938
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_35
    move-exception v102

    .line 939
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_68
    const-string v7, "starting Print Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_40

    .line 946
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_36
    move-exception v102

    .line 947
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_69
    const-string v7, "starting Theme Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_41

    .line 954
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_37
    move-exception v102

    .line 955
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_6a
    const-string v7, "starting MediaRouterService"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_42

    .line 964
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_38
    move-exception v102

    .line 965
    .restart local v102       #e:Ljava/lang/Throwable;
    :goto_6b
    const-string v7, "SystemServer"

    const-string v9, "Failure starting EdgeGesture service"

    move-object/from16 v0, v102

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_43

    .line 999
    .end local v102           #e:Ljava/lang/Throwable;
    .restart local v48       #safeMode:Z
    :cond_37
    invoke-static {}, Ldalvik/system/VMRuntime;->getRuntime()Ldalvik/system/VMRuntime;

    move-result-object v7

    invoke-virtual {v7}, Ldalvik/system/VMRuntime;->startJitCompilation()V

    goto/16 :goto_44

    .line 1006
    :catch_39
    move-exception v102

    .line 1007
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making Vibrator Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_45

    .line 1013
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_3a
    move-exception v102

    .line 1014
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making Lock Settings Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_46

    .line 1021
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_3b
    move-exception v102

    .line 1022
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making Device Policy Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_47

    .line 1029
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_3c
    move-exception v102

    .line 1030
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making Notification Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_48

    .line 1036
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_3d
    move-exception v102

    .line 1037
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making Window Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_49

    .line 1055
    .end local v102           #e:Ljava/lang/Throwable;
    .restart local v78       #config:Landroid/content/res/Configuration;
    .restart local v125       #metrics:Landroid/util/DisplayMetrics;
    .restart local v173       #w:Landroid/view/WindowManager;
    :catch_3e
    move-exception v102

    .line 1056
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making Power Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_4a

    .line 1061
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_3f
    move-exception v102

    .line 1062
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making Package Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_4b

    .line 1067
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_40
    move-exception v102

    .line 1068
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making Display Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_4c

    .line 1074
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_41
    move-exception v102

    .line 1075
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making Gesture Sensor Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_4d

    .line 1082
    .end local v102           #e:Ljava/lang/Throwable;
    :catch_42
    move-exception v102

    .line 1083
    .restart local v102       #e:Ljava/lang/Throwable;
    const-string v7, "making EdgeGesture service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v102

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_4e

    .line 313
    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v25           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v48           #safeMode:Z
    .end local v68           #appWidget:Lcom/android/server/AppWidgetService;
    .end local v70           #atlas:Lcom/android/server/AssetAtlasService;
    .end local v78           #config:Landroid/content/res/Configuration;
    .end local v84           #countryDetector:Lcom/android/server/CountryDetectorService;
    .end local v87           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .end local v100           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .end local v102           #e:Ljava/lang/Throwable;
    .end local v103           #edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    .end local v110           #gestureService:Lcom/android/server/gesture/GestureService;
    .end local v112           #hasRotationLock:Z
    .end local v113           #imm:Lcom/android/server/InputMethodManagerService;
    .end local v119           #location:Lcom/android/server/LocationManagerService;
    .end local v121           #lockSettings:Lcom/android/server/LockSettingsService;
    .end local v123           #mediaRouter:Lcom/android/server/media/MediaRouterService;
    .end local v125           #metrics:Landroid/util/DisplayMetrics;
    .end local v134           #notification:Lcom/android/server/NotificationManagerService;
    .end local v139           #printManager:Lcom/android/server/print/PrintManagerService;
    .end local v141           #profile:Lcom/android/server/ProfileManagerService;
    .end local v157           #statusBar:Lcom/android/server/StatusBarManagerService;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v161           #themeService:Lcom/android/server/ThemeService;
    .end local v163           #tsms:Lcom/android/server/TextServicesManagerService;
    .end local v173           #w:Landroid/view/WindowManager;
    .end local v174           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #battery:Lcom/android/server/BatteryService;
    .restart local v86       #cryptState:Ljava/lang/String;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v118       #lights:Lcom/android/server/LightsService;
    .restart local v130       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v143       #qcCon:Ljava/lang/Object;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_43
    move-exception v7

    goto/16 :goto_6

    .line 964
    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v72           #battery:Lcom/android/server/BatteryService;
    .end local v86           #cryptState:Ljava/lang/String;
    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v118           #lights:Lcom/android/server/LightsService;
    .end local v130           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v143           #qcCon:Ljava/lang/Object;
    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v25       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v68       #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v70       #atlas:Lcom/android/server/AssetAtlasService;
    .restart local v84       #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v87       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v100       #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .restart local v104       #edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    .restart local v110       #gestureService:Lcom/android/server/gesture/GestureService;
    .restart local v112       #hasRotationLock:Z
    .restart local v113       #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v119       #location:Lcom/android/server/LocationManagerService;
    .restart local v121       #lockSettings:Lcom/android/server/LockSettingsService;
    .restart local v123       #mediaRouter:Lcom/android/server/media/MediaRouterService;
    .restart local v134       #notification:Lcom/android/server/NotificationManagerService;
    .restart local v139       #printManager:Lcom/android/server/print/PrintManagerService;
    .restart local v141       #profile:Lcom/android/server/ProfileManagerService;
    .restart local v157       #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v161       #themeService:Lcom/android/server/ThemeService;
    .restart local v163       #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v174       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :catch_44
    move-exception v102

    move-object/from16 v103, v104

    .end local v104           #edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    .restart local v103       #edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    goto/16 :goto_6b

    .line 954
    .end local v123           #mediaRouter:Lcom/android/server/media/MediaRouterService;
    .restart local v124       #mediaRouter:Lcom/android/server/media/MediaRouterService;
    :catch_45
    move-exception v102

    move-object/from16 v123, v124

    .end local v124           #mediaRouter:Lcom/android/server/media/MediaRouterService;
    .restart local v123       #mediaRouter:Lcom/android/server/media/MediaRouterService;
    goto/16 :goto_6a

    .line 946
    .end local v161           #themeService:Lcom/android/server/ThemeService;
    .restart local v162       #themeService:Lcom/android/server/ThemeService;
    :catch_46
    move-exception v102

    move-object/from16 v161, v162

    .end local v162           #themeService:Lcom/android/server/ThemeService;
    .restart local v161       #themeService:Lcom/android/server/ThemeService;
    goto/16 :goto_69

    .line 938
    .end local v139           #printManager:Lcom/android/server/print/PrintManagerService;
    .restart local v140       #printManager:Lcom/android/server/print/PrintManagerService;
    :catch_47
    move-exception v102

    move-object/from16 v139, v140

    .end local v140           #printManager:Lcom/android/server/print/PrintManagerService;
    .restart local v139       #printManager:Lcom/android/server/print/PrintManagerService;
    goto/16 :goto_68

    .line 922
    .end local v110           #gestureService:Lcom/android/server/gesture/GestureService;
    .restart local v111       #gestureService:Lcom/android/server/gesture/GestureService;
    :catch_48
    move-exception v102

    move-object/from16 v110, v111

    .end local v111           #gestureService:Lcom/android/server/gesture/GestureService;
    .restart local v110       #gestureService:Lcom/android/server/gesture/GestureService;
    goto/16 :goto_67

    .line 911
    .end local v70           #atlas:Lcom/android/server/AssetAtlasService;
    .restart local v71       #atlas:Lcom/android/server/AssetAtlasService;
    :catch_49
    move-exception v102

    move-object/from16 v70, v71

    .end local v71           #atlas:Lcom/android/server/AssetAtlasService;
    .restart local v70       #atlas:Lcom/android/server/AssetAtlasService;
    goto/16 :goto_66

    .line 901
    .end local v100           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .restart local v101       #dreamy:Lcom/android/server/dreams/DreamManagerService;
    :catch_4a
    move-exception v102

    move-object/from16 v100, v101

    .end local v101           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .restart local v100       #dreamy:Lcom/android/server/dreams/DreamManagerService;
    goto/16 :goto_65

    .line 880
    .end local v76           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v77       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    :catch_4b
    move-exception v102

    move-object/from16 v76, v77

    .end local v77           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v76       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    goto/16 :goto_64

    .line 835
    .end local v68           #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v69       #appWidget:Lcom/android/server/AppWidgetService;
    :catch_4c
    move-exception v102

    move-object/from16 v68, v69

    .end local v69           #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v68       #appWidget:Lcom/android/server/AppWidgetService;
    goto/16 :goto_63

    .line 802
    .end local v153           #serial:Lcom/android/server/SerialService;
    .restart local v154       #serial:Lcom/android/server/SerialService;
    :catch_4d
    move-exception v102

    move-object/from16 v153, v154

    .end local v154           #serial:Lcom/android/server/SerialService;
    .restart local v153       #serial:Lcom/android/server/SerialService;
    goto/16 :goto_62

    .line 793
    .end local v169           #usb:Lcom/android/server/usb/UsbService;
    .restart local v170       #usb:Lcom/android/server/usb/UsbService;
    :catch_4e
    move-exception v102

    move-object/from16 v169, v170

    .end local v170           #usb:Lcom/android/server/usb/UsbService;
    .restart local v169       #usb:Lcom/android/server/usb/UsbService;
    goto/16 :goto_61

    .line 742
    .end local v174           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v175       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :catch_4f
    move-exception v102

    move-object/from16 v174, v175

    .end local v175           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v174       #wallpaper:Lcom/android/server/WallpaperManagerService;
    goto/16 :goto_60

    .line 711
    .end local v84           #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v85       #countryDetector:Lcom/android/server/CountryDetectorService;
    :catch_50
    move-exception v102

    move-object/from16 v84, v85

    .end local v85           #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v84       #countryDetector:Lcom/android/server/CountryDetectorService;
    goto/16 :goto_5f

    .line 703
    .end local v119           #location:Lcom/android/server/LocationManagerService;
    .restart local v120       #location:Lcom/android/server/LocationManagerService;
    :catch_51
    move-exception v102

    move-object/from16 v119, v120

    .end local v120           #location:Lcom/android/server/LocationManagerService;
    .restart local v119       #location:Lcom/android/server/LocationManagerService;
    goto/16 :goto_5e

    .line 686
    .end local v134           #notification:Lcom/android/server/NotificationManagerService;
    .restart local v135       #notification:Lcom/android/server/NotificationManagerService;
    :catch_52
    move-exception v102

    move-object/from16 v134, v135

    .end local v135           #notification:Lcom/android/server/NotificationManagerService;
    .restart local v134       #notification:Lcom/android/server/NotificationManagerService;
    goto/16 :goto_5d

    .line 677
    .end local v141           #profile:Lcom/android/server/ProfileManagerService;
    .restart local v142       #profile:Lcom/android/server/ProfileManagerService;
    :catch_53
    move-exception v102

    move-object/from16 v141, v142

    .end local v142           #profile:Lcom/android/server/ProfileManagerService;
    .restart local v141       #profile:Lcom/android/server/ProfileManagerService;
    goto/16 :goto_5c

    .line 583
    .end local v176           #wifi:Lcom/android/server/wifi/WifiService;
    .restart local v143       #qcCon:Ljava/lang/Object;
    .restart local v177       #wifi:Lcom/android/server/wifi/WifiService;
    :catch_54
    move-exception v102

    move-object/from16 v176, v177

    .end local v177           #wifi:Lcom/android/server/wifi/WifiService;
    .restart local v176       #wifi:Lcom/android/server/wifi/WifiService;
    goto/16 :goto_5b

    .line 575
    .end local v178           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v179       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    :catch_55
    move-exception v102

    move-object/from16 v178, v179

    .end local v179           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v178       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    goto/16 :goto_5a

    .line 567
    :catch_56
    move-exception v102

    goto/16 :goto_59

    .line 557
    .end local v25           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v29           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v130       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v131       #networkStats:Lcom/android/server/net/NetworkStatsService;
    :catch_57
    move-exception v102

    move-object/from16 v29, v131

    .end local v131           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v29       #networkStats:Lcom/android/server/net/NetworkStatsService;
    goto/16 :goto_58

    .line 547
    .end local v163           #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v164       #tsms:Lcom/android/server/TextServicesManagerService;
    :catch_58
    move-exception v102

    move-object/from16 v163, v164

    .end local v164           #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v163       #tsms:Lcom/android/server/TextServicesManagerService;
    goto/16 :goto_57

    .line 517
    .end local v157           #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v158       #statusBar:Lcom/android/server/StatusBarManagerService;
    :catch_59
    move-exception v102

    move-object/from16 v157, v158

    .end local v158           #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v157       #statusBar:Lcom/android/server/StatusBarManagerService;
    goto/16 :goto_56

    .line 507
    .end local v87           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v88       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    :catch_5a
    move-exception v102

    move-object/from16 v87, v88

    .end local v88           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v87       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    goto/16 :goto_55

    .line 499
    .end local v121           #lockSettings:Lcom/android/server/LockSettingsService;
    .restart local v122       #lockSettings:Lcom/android/server/LockSettingsService;
    :catch_5b
    move-exception v102

    move-object/from16 v121, v122

    .end local v122           #lockSettings:Lcom/android/server/LockSettingsService;
    .restart local v121       #lockSettings:Lcom/android/server/LockSettingsService;
    goto/16 :goto_54

    .line 489
    .end local v126           #mountService:Lcom/android/server/MountService;
    .restart local v127       #mountService:Lcom/android/server/MountService;
    :catch_5c
    move-exception v102

    move-object/from16 v126, v127

    .end local v127           #mountService:Lcom/android/server/MountService;
    .restart local v126       #mountService:Lcom/android/server/MountService;
    goto/16 :goto_53

    .line 475
    :catch_5d
    move-exception v7

    goto/16 :goto_11

    .line 444
    .end local v113           #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v114       #imm:Lcom/android/server/InputMethodManagerService;
    :catch_5e
    move-exception v102

    move-object/from16 v113, v114

    .end local v114           #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v113       #imm:Lcom/android/server/InputMethodManagerService;
    goto/16 :goto_52

    .line 409
    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v11           #display:Lcom/android/server/display/DisplayManagerService;
    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v68           #appWidget:Lcom/android/server/AppWidgetService;
    .end local v70           #atlas:Lcom/android/server/AssetAtlasService;
    .end local v84           #countryDetector:Lcom/android/server/CountryDetectorService;
    .end local v87           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .end local v100           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .end local v103           #edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    .end local v110           #gestureService:Lcom/android/server/gesture/GestureService;
    .end local v112           #hasRotationLock:Z
    .end local v113           #imm:Lcom/android/server/InputMethodManagerService;
    .end local v119           #location:Lcom/android/server/LocationManagerService;
    .end local v121           #lockSettings:Lcom/android/server/LockSettingsService;
    .end local v123           #mediaRouter:Lcom/android/server/media/MediaRouterService;
    .end local v134           #notification:Lcom/android/server/NotificationManagerService;
    .end local v139           #printManager:Lcom/android/server/print/PrintManagerService;
    .end local v141           #profile:Lcom/android/server/ProfileManagerService;
    .end local v157           #statusBar:Lcom/android/server/StatusBarManagerService;
    .end local v161           #themeService:Lcom/android/server/ThemeService;
    .end local v163           #tsms:Lcom/android/server/TextServicesManagerService;
    .end local v174           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #battery:Lcom/android/server/BatteryService;
    .restart local v97       #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v118       #lights:Lcom/android/server/LightsService;
    :catch_5f
    move-exception v102

    move-object/from16 v20, v115

    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v16, v67

    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v72

    .end local v72           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v11, v97

    .end local v97           #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v11       #display:Lcom/android/server/display/DisplayManagerService;
    move-object/from16 v6, v118

    .end local v118           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    goto/16 :goto_51

    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #battery:Lcom/android/server/BatteryService;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v118       #lights:Lcom/android/server/LightsService;
    :catch_60
    move-exception v102

    move-object/from16 v20, v115

    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v16, v67

    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v72

    .end local v72           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v6, v118

    .end local v118           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    goto/16 :goto_51

    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v128           #msimTelephonyRegistry:Lcom/android/server/MSimTelephonyRegistry;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #battery:Lcom/android/server/BatteryService;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v118       #lights:Lcom/android/server/LightsService;
    .restart local v129       #msimTelephonyRegistry:Lcom/android/server/MSimTelephonyRegistry;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_61
    move-exception v102

    move-object/from16 v128, v129

    .end local v129           #msimTelephonyRegistry:Lcom/android/server/MSimTelephonyRegistry;
    .restart local v128       #msimTelephonyRegistry:Lcom/android/server/MSimTelephonyRegistry;
    move-object/from16 v159, v160

    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v20, v115

    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v16, v67

    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v72

    .end local v72           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v6, v118

    .end local v118           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    goto/16 :goto_51

    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v65           #accountManager:Lcom/android/server/accounts/AccountManagerService;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v66       #accountManager:Lcom/android/server/accounts/AccountManagerService;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #battery:Lcom/android/server/BatteryService;
    .restart local v86       #cryptState:Ljava/lang/String;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v118       #lights:Lcom/android/server/LightsService;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_62
    move-exception v102

    move-object/from16 v159, v160

    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v20, v115

    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v16, v67

    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v72

    .end local v72           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v6, v118

    .end local v118           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    move-object/from16 v65, v66

    .end local v66           #accountManager:Lcom/android/server/accounts/AccountManagerService;
    .restart local v65       #accountManager:Lcom/android/server/accounts/AccountManagerService;
    goto/16 :goto_51

    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #battery:Lcom/android/server/BatteryService;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_63
    move-exception v102

    move-object/from16 v159, v160

    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v20, v115

    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v16, v67

    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v72

    .end local v72           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    goto/16 :goto_51

    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_64
    move-exception v102

    move-object/from16 v159, v160

    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v20, v115

    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v16, v67

    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    goto/16 :goto_51

    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v171           #vibrator:Lcom/android/server/VibratorService;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v172       #vibrator:Lcom/android/server/VibratorService;
    :catch_65
    move-exception v102

    move-object/from16 v159, v160

    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v20, v115

    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v16, v67

    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v171, v172

    .end local v172           #vibrator:Lcom/android/server/VibratorService;
    .restart local v171       #vibrator:Lcom/android/server/VibratorService;
    goto/16 :goto_51

    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v81           #consumerIr:Lcom/android/server/ConsumerIrService;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v171           #vibrator:Lcom/android/server/VibratorService;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v82       #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v172       #vibrator:Lcom/android/server/VibratorService;
    :catch_66
    move-exception v102

    move-object/from16 v81, v82

    .end local v82           #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v81       #consumerIr:Lcom/android/server/ConsumerIrService;
    move-object/from16 v159, v160

    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v20, v115

    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v16, v67

    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v171, v172

    .end local v172           #vibrator:Lcom/android/server/VibratorService;
    .restart local v171       #vibrator:Lcom/android/server/VibratorService;
    goto/16 :goto_51

    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v81           #consumerIr:Lcom/android/server/ConsumerIrService;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v171           #vibrator:Lcom/android/server/VibratorService;
    .restart local v82       #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v172       #vibrator:Lcom/android/server/VibratorService;
    :catch_67
    move-exception v102

    move-object/from16 v81, v82

    .end local v82           #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v81       #consumerIr:Lcom/android/server/ConsumerIrService;
    move-object/from16 v159, v160

    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v20, v115

    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v171, v172

    .end local v172           #vibrator:Lcom/android/server/VibratorService;
    .restart local v171       #vibrator:Lcom/android/server/VibratorService;
    goto/16 :goto_51

    .end local v73           #bluetooth:Lcom/android/server/BluetoothManagerService;
    .end local v81           #consumerIr:Lcom/android/server/ConsumerIrService;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v171           #vibrator:Lcom/android/server/VibratorService;
    .restart local v74       #bluetooth:Lcom/android/server/BluetoothManagerService;
    .restart local v82       #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v172       #vibrator:Lcom/android/server/VibratorService;
    :catch_68
    move-exception v102

    move-object/from16 v81, v82

    .end local v82           #consumerIr:Lcom/android/server/ConsumerIrService;
    .restart local v81       #consumerIr:Lcom/android/server/ConsumerIrService;
    move-object/from16 v159, v160

    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v73, v74

    .end local v74           #bluetooth:Lcom/android/server/BluetoothManagerService;
    .restart local v73       #bluetooth:Lcom/android/server/BluetoothManagerService;
    move-object/from16 v171, v172

    .end local v172           #vibrator:Lcom/android/server/VibratorService;
    .restart local v171       #vibrator:Lcom/android/server/VibratorService;
    goto/16 :goto_51

    .line 333
    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v16           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v20           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v65           #accountManager:Lcom/android/server/accounts/AccountManagerService;
    .end local v159           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v66       #accountManager:Lcom/android/server/accounts/AccountManagerService;
    .restart local v67       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #battery:Lcom/android/server/BatteryService;
    .restart local v115       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v118       #lights:Lcom/android/server/LightsService;
    .restart local v160       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_69
    move-exception v102

    move-object/from16 v65, v66

    .end local v66           #accountManager:Lcom/android/server/accounts/AccountManagerService;
    .restart local v65       #accountManager:Lcom/android/server/accounts/AccountManagerService;
    goto/16 :goto_50

    .line 258
    .end local v11           #display:Lcom/android/server/display/DisplayManagerService;
    .end local v86           #cryptState:Ljava/lang/String;
    .end local v89           #disableBluetooth:Z
    .end local v90           #disableLocation:Z
    .end local v91           #disableMedia:Z
    .end local v92           #disableNetwork:Z
    .end local v93           #disableNonCoreServices:Z
    .end local v94           #disableStorage:Z
    .end local v95           #disableSystemUI:Z
    .end local v96           #disableTelephony:Z
    .end local v116           #installer:Lcom/android/server/pm/Installer;
    .end local v160           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v97       #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v117       #installer:Lcom/android/server/pm/Installer;
    .restart local v159       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_6a
    move-exception v102

    move-object/from16 v116, v117

    .end local v117           #installer:Lcom/android/server/pm/Installer;
    .restart local v116       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_4f

    .end local v4           #power:Lcom/android/server/power/PowerManagerService;
    .end local v116           #installer:Lcom/android/server/pm/Installer;
    .restart local v117       #installer:Lcom/android/server/pm/Installer;
    .restart local v138       #power:Lcom/android/server/power/PowerManagerService;
    :catch_6b
    move-exception v102

    move-object/from16 v4, v138

    .end local v138           #power:Lcom/android/server/power/PowerManagerService;
    .restart local v4       #power:Lcom/android/server/power/PowerManagerService;
    move-object/from16 v116, v117

    .end local v117           #installer:Lcom/android/server/pm/Installer;
    .restart local v116       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_4f

    .end local v67           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v72           #battery:Lcom/android/server/BatteryService;
    .end local v97           #display:Lcom/android/server/display/DisplayManagerService;
    .end local v115           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v118           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    .restart local v11       #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v16       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v20       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v68       #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v70       #atlas:Lcom/android/server/AssetAtlasService;
    .restart local v84       #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v87       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v89       #disableBluetooth:Z
    .restart local v90       #disableLocation:Z
    .restart local v91       #disableMedia:Z
    .restart local v92       #disableNetwork:Z
    .restart local v93       #disableNonCoreServices:Z
    .restart local v94       #disableStorage:Z
    .restart local v95       #disableSystemUI:Z
    .restart local v96       #disableTelephony:Z
    .restart local v100       #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .restart local v103       #edgeGestureService:Lcom/android/server/gesture/EdgeGestureService;
    .restart local v110       #gestureService:Lcom/android/server/gesture/GestureService;
    .restart local v112       #hasRotationLock:Z
    .restart local v113       #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v119       #location:Lcom/android/server/LocationManagerService;
    .restart local v121       #lockSettings:Lcom/android/server/LockSettingsService;
    .restart local v123       #mediaRouter:Lcom/android/server/media/MediaRouterService;
    .restart local v134       #notification:Lcom/android/server/NotificationManagerService;
    .restart local v139       #printManager:Lcom/android/server/print/PrintManagerService;
    .restart local v141       #profile:Lcom/android/server/ProfileManagerService;
    .restart local v157       #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v161       #themeService:Lcom/android/server/ThemeService;
    .restart local v163       #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v174       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :cond_38
    move-object/from16 v25, v130

    .end local v130           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v25       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    goto/16 :goto_20

    .end local v25           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v130       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    :cond_39
    move-object/from16 v25, v130

    .end local v130           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v25       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    goto/16 :goto_43
.end method

.method reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 3
    .parameter "msg"
    .parameter "e"

    .prologue
    .line 107
    const-string v0, "SystemServer"

    const-string v1, "***********************************************"

    invoke-static {v0, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 108
    const-string v0, "SystemServer"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "BOOT FAILURE "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, p2}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 109
    return-void
.end method
