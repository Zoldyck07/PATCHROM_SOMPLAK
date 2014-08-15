.class public final Lcom/android/server/pm/Installer;
.super Ljava/lang/Object;
.source "Installer.java"


# static fields
.field private static final LOCAL_DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "Installer"


# instance fields
.field buf:[B

.field buflen:I

.field id:I

.field mHandler:Landroid/os/Handler;

.field mIn:Ljava/io/InputStream;

.field mLastTransactionId:I

.field mOut:Ljava/io/OutputStream;

.field final mPendingRequests:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field mPollRunnable:Ljava/lang/Runnable;

.field mPollerThread:Ljava/lang/Thread;

.field final mResponses:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field mSocket:Landroid/net/LocalSocket;

.field final mTransactionIdLock:Ljava/lang/Object;

.field needPolling:Z


# direct methods
.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    const/16 v0, 0x400

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/android/server/pm/Installer;->buf:[B

    .line 45
    iput v2, p0, Lcom/android/server/pm/Installer;->buflen:I

    .line 47
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Lcom/android/server/pm/Installer;->mResponses:Landroid/util/SparseArray;

    .line 48
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/server/pm/Installer;->mPendingRequests:Ljava/util/ArrayList;

    .line 49
    iput v2, p0, Lcom/android/server/pm/Installer;->mLastTransactionId:I

    .line 50
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/server/pm/Installer;->mTransactionIdLock:Ljava/lang/Object;

    .line 277
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/android/server/pm/Installer$1;

    invoke-direct {v1, p0}, Lcom/android/server/pm/Installer$1;-><init>(Lcom/android/server/pm/Installer;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    iput-object v0, p0, Lcom/android/server/pm/Installer;->mPollerThread:Ljava/lang/Thread;

    .line 293
    iput-boolean v2, p0, Lcom/android/server/pm/Installer;->needPolling:Z

    .line 294
    new-instance v0, Lcom/android/server/pm/Installer$2;

    invoke-direct {v0, p0}, Lcom/android/server/pm/Installer$2;-><init>(Lcom/android/server/pm/Installer;)V

    iput-object v0, p0, Lcom/android/server/pm/Installer;->mPollRunnable:Ljava/lang/Runnable;

    .line 54
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mPollerThread:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 55
    return-void
.end method

.method static synthetic access$000(Lcom/android/server/pm/Installer;)V
    .locals 0
    .parameter "x0"

    .prologue
    .line 32
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->checkPoller()V

    return-void
.end method

.method static synthetic access$100(Lcom/android/server/pm/Installer;)Z
    .locals 1
    .parameter "x0"

    .prologue
    .line 32
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->readReply()Z

    move-result v0

    return v0
.end method

.method private checkPoller()V
    .locals 3

    .prologue
    .line 259
    iget-object v1, p0, Lcom/android/server/pm/Installer;->mPendingRequests:Ljava/util/ArrayList;

    monitor-enter v1

    .line 264
    :try_start_0
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mHandler:Landroid/os/Handler;

    if-eqz v0, :cond_0

    .line 265
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mPendingRequests:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 266
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/server/pm/Installer;->needPolling:Z

    .line 267
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mHandler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/android/server/pm/Installer;->mPollRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 273
    :cond_0
    :goto_0
    monitor-exit v1

    .line 274
    return-void

    .line 269
    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/server/pm/Installer;->needPolling:Z

    .line 270
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mHandler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/android/server/pm/Installer;->mPollRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 273
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private connect()Z
    .locals 5

    .prologue
    const/4 v2, 0x1

    .line 58
    iget-object v3, p0, Lcom/android/server/pm/Installer;->mSocket:Landroid/net/LocalSocket;

    if-eqz v3, :cond_0

    .line 76
    :goto_0
    return v2

    .line 61
    :cond_0
    const-string v3, "Installer"

    const-string v4, "connecting..."

    invoke-static {v3, v4}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 63
    :try_start_0
    new-instance v3, Landroid/net/LocalSocket;

    invoke-direct {v3}, Landroid/net/LocalSocket;-><init>()V

    iput-object v3, p0, Lcom/android/server/pm/Installer;->mSocket:Landroid/net/LocalSocket;

    .line 65
    new-instance v0, Landroid/net/LocalSocketAddress;

    const-string v3, "installd"

    sget-object v4, Landroid/net/LocalSocketAddress$Namespace;->RESERVED:Landroid/net/LocalSocketAddress$Namespace;

    invoke-direct {v0, v3, v4}, Landroid/net/LocalSocketAddress;-><init>(Ljava/lang/String;Landroid/net/LocalSocketAddress$Namespace;)V

    .line 68
    .local v0, address:Landroid/net/LocalSocketAddress;
    iget-object v3, p0, Lcom/android/server/pm/Installer;->mSocket:Landroid/net/LocalSocket;

    invoke-virtual {v3, v0}, Landroid/net/LocalSocket;->connect(Landroid/net/LocalSocketAddress;)V

    .line 70
    iget-object v3, p0, Lcom/android/server/pm/Installer;->mSocket:Landroid/net/LocalSocket;

    invoke-virtual {v3}, Landroid/net/LocalSocket;->getInputStream()Ljava/io/InputStream;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/pm/Installer;->mIn:Ljava/io/InputStream;

    .line 71
    iget-object v3, p0, Lcom/android/server/pm/Installer;->mSocket:Landroid/net/LocalSocket;

    invoke-virtual {v3}, Landroid/net/LocalSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/pm/Installer;->mOut:Ljava/io/OutputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 72
    .end local v0           #address:Landroid/net/LocalSocketAddress;
    :catch_0
    move-exception v1

    .line 73
    .local v1, ex:Ljava/io/IOException;
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->disconnect()V

    .line 74
    const/4 v2, 0x0

    goto :goto_0
.end method

.method private disconnect()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 80
    const-string v0, "Installer"

    const-string v1, "disconnecting..."

    invoke-static {v0, v1}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 82
    :try_start_0
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mSocket:Landroid/net/LocalSocket;

    if-eqz v0, :cond_0

    .line 83
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mSocket:Landroid/net/LocalSocket;

    invoke-virtual {v0}, Landroid/net/LocalSocket;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2

    .line 87
    :cond_0
    :goto_0
    :try_start_1
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mIn:Ljava/io/InputStream;

    if-eqz v0, :cond_1

    .line 88
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mIn:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 92
    :cond_1
    :goto_1
    :try_start_2
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mOut:Ljava/io/OutputStream;

    if-eqz v0, :cond_2

    .line 93
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mOut:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 96
    :cond_2
    :goto_2
    iput-object v2, p0, Lcom/android/server/pm/Installer;->mSocket:Landroid/net/LocalSocket;

    .line 97
    iput-object v2, p0, Lcom/android/server/pm/Installer;->mIn:Ljava/io/InputStream;

    .line 98
    iput-object v2, p0, Lcom/android/server/pm/Installer;->mOut:Ljava/io/OutputStream;

    .line 100
    iget-object v1, p0, Lcom/android/server/pm/Installer;->mPendingRequests:Ljava/util/ArrayList;

    monitor-enter v1

    .line 101
    :try_start_3
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mPendingRequests:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 102
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->checkPoller()V

    .line 103
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 104
    iget-object v1, p0, Lcom/android/server/pm/Installer;->mResponses:Landroid/util/SparseArray;

    monitor-enter v1

    .line 105
    :try_start_4
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mResponses:Landroid/util/SparseArray;

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    .line 106
    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 107
    return-void

    .line 103
    :catchall_0
    move-exception v0

    :try_start_5
    monitor-exit v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw v0

    .line 106
    :catchall_1
    move-exception v0

    :try_start_6
    monitor-exit v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    throw v0

    .line 94
    :catch_0
    move-exception v0

    goto :goto_2

    .line 89
    :catch_1
    move-exception v0

    goto :goto_1

    .line 84
    :catch_2
    move-exception v0

    goto :goto_0
.end method

.method private execute(Ljava/lang/String;)I
    .locals 3
    .parameter "cmd"

    .prologue
    .line 314
    invoke-direct {p0, p1}, Lcom/android/server/pm/Installer;->transaction(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 316
    .local v1, res:Ljava/lang/String;
    :try_start_0
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 318
    :goto_0
    return v2

    .line 317
    :catch_0
    move-exception v0

    .line 318
    .local v0, ex:Ljava/lang/NumberFormatException;
    const/4 v2, -0x1

    goto :goto_0
.end method

.method private declared-synchronized readBytes([BI)Z
    .locals 8
    .parameter "buffer"
    .parameter "len"

    .prologue
    const/4 v4, 0x0

    .line 110
    monitor-enter p0

    const/4 v3, 0x0

    .line 112
    .local v3, off:I
    if-ltz p2, :cond_0

    :try_start_0
    iget-object v5, p0, Lcom/android/server/pm/Installer;->mIn:Ljava/io/InputStream;

    invoke-virtual {v5}, Ljava/io/InputStream;->available()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v5

    if-ge v5, p2, :cond_2

    .line 136
    :cond_0
    :goto_0
    monitor-exit p0

    return v4

    .line 114
    :catch_0
    move-exception v1

    .line 115
    .local v1, e:Ljava/io/IOException;
    goto :goto_0

    .line 124
    .end local v1           #e:Ljava/io/IOException;
    .local v0, count:I
    :cond_1
    add-int/2addr v3, v0

    .line 117
    .end local v0           #count:I
    :cond_2
    if-eq v3, p2, :cond_3

    .line 119
    :try_start_1
    iget-object v5, p0, Lcom/android/server/pm/Installer;->mIn:Ljava/io/InputStream;

    sub-int v6, p2, v3

    invoke-virtual {v5, p1, v3, v6}, Ljava/io/InputStream;->read([BII)I

    move-result v0

    .line 120
    .restart local v0       #count:I
    if-gtz v0, :cond_1

    .line 121
    const-string v5, "Installer"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "read error "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 133
    .end local v0           #count:I
    :cond_3
    :goto_1
    if-ne v3, p2, :cond_4

    .line 134
    const/4 v4, 0x1

    goto :goto_0

    .line 125
    :catch_1
    move-exception v2

    .line 126
    .local v2, ex:Ljava/io/IOException;
    :try_start_2
    const-string v5, "Installer"

    const-string v6, "read exception"

    invoke-static {v5, v6}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    .line 110
    .end local v2           #ex:Ljava/io/IOException;
    :catchall_0
    move-exception v4

    monitor-exit p0

    throw v4

    .line 135
    :cond_4
    :try_start_3
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->disconnect()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0
.end method

.method private readReply()Z
    .locals 6

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 141
    iput v1, p0, Lcom/android/server/pm/Installer;->buflen:I

    .line 142
    iget-object v3, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v4, 0x6

    invoke-direct {p0, v3, v4}, Lcom/android/server/pm/Installer;->readBytes([BI)Z

    move-result v3

    if-nez v3, :cond_1

    .line 156
    :cond_0
    :goto_0
    return v1

    .line 144
    :cond_1
    iget-object v3, p0, Lcom/android/server/pm/Installer;->buf:[B

    aget-byte v3, v3, v1

    and-int/lit16 v3, v3, 0xff

    iget-object v4, p0, Lcom/android/server/pm/Installer;->buf:[B

    aget-byte v4, v4, v2

    and-int/lit16 v4, v4, 0xff

    shl-int/lit8 v4, v4, 0x8

    or-int/2addr v3, v4

    iget-object v4, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v5, 0x2

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    shl-int/lit8 v4, v4, 0x10

    or-int/2addr v3, v4

    iget-object v4, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v5, 0x3

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    shl-int/lit8 v4, v4, 0x18

    or-int/2addr v3, v4

    iput v3, p0, Lcom/android/server/pm/Installer;->id:I

    .line 147
    iget-object v3, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v4, 0x4

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    iget-object v4, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v5, 0x5

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    shl-int/lit8 v4, v4, 0x8

    or-int v0, v3, v4

    .line 148
    .local v0, len:I
    if-lt v0, v2, :cond_2

    const/16 v3, 0x400

    if-le v0, v3, :cond_3

    .line 149
    :cond_2
    const-string v2, "Installer"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "invalid reply length ("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ")"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 150
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->disconnect()V

    goto :goto_0

    .line 153
    :cond_3
    iget-object v3, p0, Lcom/android/server/pm/Installer;->buf:[B

    invoke-direct {p0, v3, v0}, Lcom/android/server/pm/Installer;->readBytes([BI)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 155
    iput v0, p0, Lcom/android/server/pm/Installer;->buflen:I

    move v1, v2

    .line 156
    goto :goto_0
.end method

.method private transaction(Ljava/lang/String;)Ljava/lang/String;
    .locals 13
    .parameter "cmd"

    .prologue
    const-wide/32 v11, 0x186a0

    .line 193
    iget-object v8, p0, Lcom/android/server/pm/Installer;->mTransactionIdLock:Ljava/lang/Object;

    monitor-enter v8

    .line 194
    :try_start_0
    iget v6, p0, Lcom/android/server/pm/Installer;->mLastTransactionId:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/android/server/pm/Installer;->mLastTransactionId:I

    .line 195
    .local v6, transactionId:I
    iget v7, p0, Lcom/android/server/pm/Installer;->mLastTransactionId:I

    if-gez v7, :cond_0

    .line 196
    const/4 v7, 0x0

    iput v7, p0, Lcom/android/server/pm/Installer;->mLastTransactionId:I

    .line 198
    :cond_0
    monitor-exit v8
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 201
    :try_start_1
    iget-object v8, p0, Lcom/android/server/pm/Installer;->mResponses:Landroid/util/SparseArray;

    monitor-enter v8
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0

    .line 202
    :try_start_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 203
    .local v2, startWaitTime:J
    :goto_0
    iget-object v7, p0, Lcom/android/server/pm/Installer;->mResponses:Landroid/util/SparseArray;

    invoke-virtual {v7, v6}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v7

    if-nez v7, :cond_7

    .line 204
    iget-object v9, p0, Lcom/android/server/pm/Installer;->mPendingRequests:Ljava/util/ArrayList;

    monitor-enter v9
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 205
    :try_start_3
    iget-object v7, p0, Lcom/android/server/pm/Installer;->mPendingRequests:Ljava/util/ArrayList;

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v7, v10}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_5

    .line 206
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->connect()Z

    move-result v7

    if-nez v7, :cond_2

    .line 207
    const-string v7, "Installer"

    const-string v10, "connection failed"

    invoke-static {v7, v10}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 208
    const-string v1, "-1"

    monitor-exit v9
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    :try_start_4
    monitor-exit v8
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 255
    .end local v2           #startWaitTime:J
    :cond_1
    :goto_1
    return-object v1

    .line 198
    .end local v6           #transactionId:I
    :catchall_0
    move-exception v7

    :try_start_5
    monitor-exit v8
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw v7

    .line 211
    .restart local v2       #startWaitTime:J
    .restart local v6       #transactionId:I
    :cond_2
    :try_start_6
    invoke-direct {p0, p1, v6}, Lcom/android/server/pm/Installer;->writeCommand(Ljava/lang/String;I)Z

    move-result v7

    if-nez v7, :cond_4

    .line 217
    const-string v7, "Installer"

    const-string v10, "write command failed? reconnect!"

    invoke-static {v7, v10}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 218
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->connect()Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-direct {p0, p1, v6}, Lcom/android/server/pm/Installer;->writeCommand(Ljava/lang/String;I)Z

    move-result v7

    if-nez v7, :cond_4

    .line 219
    :cond_3
    const-string v1, "-1"

    monitor-exit v9
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    :try_start_7
    monitor-exit v8

    goto :goto_1

    .line 237
    .end local v2           #startWaitTime:J
    :catchall_1
    move-exception v7

    monitor-exit v8
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    :try_start_8
    throw v7
    :try_end_8
    .catch Ljava/lang/InterruptedException; {:try_start_8 .. :try_end_8} :catch_0

    .line 238
    :catch_0
    move-exception v0

    .line 239
    .local v0, e:Ljava/lang/InterruptedException;
    const-string v1, "-1"

    goto :goto_1

    .line 225
    .end local v0           #e:Ljava/lang/InterruptedException;
    .restart local v2       #startWaitTime:J
    :cond_4
    :try_start_9
    iget-object v7, p0, Lcom/android/server/pm/Installer;->mPendingRequests:Ljava/util/ArrayList;

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v7, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 226
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->checkPoller()V

    .line 228
    :cond_5
    monitor-exit v9
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    .line 229
    :try_start_a
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    sub-long v9, v2, v9

    add-long v4, v9, v11

    .line 230
    .local v4, timeToWait:J
    const-wide/16 v9, 0x0

    cmp-long v7, v4, v9

    if-lez v7, :cond_6

    .line 231
    iget-object v7, p0, Lcom/android/server/pm/Installer;->mResponses:Landroid/util/SparseArray;

    const-wide/32 v9, 0x186a0

    invoke-virtual {v7, v9, v10}, Ljava/lang/Object;->wait(J)V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    goto :goto_0

    .line 228
    .end local v4           #timeToWait:J
    :catchall_2
    move-exception v7

    :try_start_b
    monitor-exit v9
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    :try_start_c
    throw v7

    .line 233
    .restart local v4       #timeToWait:J
    :cond_6
    const-string v7, "Installer"

    const-string v9, "timeout wating for response"

    invoke-static {v7, v9}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 237
    .end local v4           #timeToWait:J
    :cond_7
    monitor-exit v8
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_1

    .line 242
    iget-object v8, p0, Lcom/android/server/pm/Installer;->mPendingRequests:Ljava/util/ArrayList;

    monitor-enter v8

    .line 243
    :try_start_d
    iget-object v7, p0, Lcom/android/server/pm/Installer;->mPendingRequests:Ljava/util/ArrayList;

    new-instance v9, Ljava/lang/Integer;

    invoke-direct {v9, v6}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v7, v9}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 244
    monitor-exit v8
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_3

    .line 245
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->checkPoller()V

    .line 248
    iget-object v8, p0, Lcom/android/server/pm/Installer;->mResponses:Landroid/util/SparseArray;

    monitor-enter v8

    .line 249
    :try_start_e
    iget-object v7, p0, Lcom/android/server/pm/Installer;->mResponses:Landroid/util/SparseArray;

    invoke-virtual {v7, v6}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 250
    .local v1, s:Ljava/lang/String;
    iget-object v7, p0, Lcom/android/server/pm/Installer;->mResponses:Landroid/util/SparseArray;

    invoke-virtual {v7, v6}, Landroid/util/SparseArray;->remove(I)V

    .line 251
    monitor-exit v8
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_4

    .line 255
    if-nez v1, :cond_1

    const-string v1, "-1"

    goto :goto_1

    .line 244
    .end local v1           #s:Ljava/lang/String;
    :catchall_3
    move-exception v7

    :try_start_f
    monitor-exit v8
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_3

    throw v7

    .line 251
    :catchall_4
    move-exception v7

    :try_start_10
    monitor-exit v8
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_4

    throw v7
.end method

.method private declared-synchronized writeCommand(Ljava/lang/String;I)Z
    .locals 10
    .parameter "_cmd"
    .parameter "id"

    .prologue
    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 160
    monitor-enter p0

    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    .line 161
    .local v0, cmd:[B
    array-length v3, v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 162
    .local v3, len:I
    if-lt v3, v4, :cond_0

    const/16 v6, 0x400

    if-le v3, v6, :cond_1

    :cond_0
    move v4, v5

    .line 187
    :goto_0
    monitor-exit p0

    return v4

    .line 164
    :cond_1
    :try_start_1
    iget-object v6, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v7, 0x0

    and-int/lit16 v8, p2, 0xff

    int-to-byte v8, v8

    aput-byte v8, v6, v7

    .line 165
    iget-object v6, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v7, 0x1

    shr-int/lit8 v8, p2, 0x8

    and-int/lit16 v8, v8, 0xff

    int-to-byte v8, v8

    aput-byte v8, v6, v7

    .line 166
    iget-object v6, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v7, 0x2

    shr-int/lit8 v8, p2, 0x10

    and-int/lit16 v8, v8, 0xff

    int-to-byte v8, v8

    aput-byte v8, v6, v7

    .line 167
    iget-object v6, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v7, 0x3

    shr-int/lit8 v8, p2, 0x18

    and-int/lit16 v8, v8, 0xff

    int-to-byte v8, v8

    aput-byte v8, v6, v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 170
    :try_start_2
    iget-object v6, p0, Lcom/android/server/pm/Installer;->mOut:Ljava/io/OutputStream;

    iget-object v7, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v8, 0x0

    const/4 v9, 0x4

    invoke-virtual {v6, v7, v8, v9}, Ljava/io/OutputStream;->write([BII)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .line 177
    :try_start_3
    iget-object v6, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v7, 0x0

    and-int/lit16 v8, v3, 0xff

    int-to-byte v8, v8

    aput-byte v8, v6, v7

    .line 178
    iget-object v6, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v7, 0x1

    shr-int/lit8 v8, v3, 0x8

    and-int/lit16 v8, v8, 0xff

    int-to-byte v8, v8

    aput-byte v8, v6, v7
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 180
    :try_start_4
    iget-object v6, p0, Lcom/android/server/pm/Installer;->mOut:Ljava/io/OutputStream;

    iget-object v7, p0, Lcom/android/server/pm/Installer;->buf:[B

    const/4 v8, 0x0

    const/4 v9, 0x2

    invoke-virtual {v6, v7, v8, v9}, Ljava/io/OutputStream;->write([BII)V

    .line 181
    iget-object v6, p0, Lcom/android/server/pm/Installer;->mOut:Ljava/io/OutputStream;

    const/4 v7, 0x0

    invoke-virtual {v6, v0, v7, v3}, Ljava/io/OutputStream;->write([BII)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_0

    .line 182
    :catch_0
    move-exception v2

    .line 183
    .local v2, ex:Ljava/io/IOException;
    :try_start_5
    const-string v4, "Installer"

    const-string v6, "write error"

    invoke-static {v4, v6}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 184
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->disconnect()V

    move v4, v5

    .line 185
    goto :goto_0

    .line 171
    .end local v2           #ex:Ljava/io/IOException;
    :catch_1
    move-exception v1

    .line 172
    .local v1, e:Ljava/io/IOException;
    const-string v4, "Installer"

    const-string v6, "write error"

    invoke-static {v4, v6}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 173
    invoke-direct {p0}, Lcom/android/server/pm/Installer;->disconnect()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move v4, v5

    .line 174
    goto :goto_0

    .line 160
    .end local v0           #cmd:[B
    .end local v1           #e:Ljava/io/IOException;
    .end local v3           #len:I
    :catchall_0
    move-exception v4

    monitor-exit p0

    throw v4
.end method


# virtual methods
.method public aapt(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)I
    .locals 3
    .parameter "themeApkPath"
    .parameter "internalPath"
    .parameter "resTablePath"
    .parameter "uid"
    .parameter "pkgId"

    .prologue
    const/16 v2, 0x20

    .line 366
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "aapt"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 367
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 368
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 369
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 370
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 371
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 372
    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 373
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 374
    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 375
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 376
    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 377
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1
.end method

.method public clearUserData(Ljava/lang/String;I)I
    .locals 3
    .parameter "name"
    .parameter "userId"

    .prologue
    const/16 v2, 0x20

    .line 455
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "rmuserdata"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 456
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 457
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 458
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 459
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 460
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1
.end method

.method public createUserData(Ljava/lang/String;IILjava/lang/String;)I
    .locals 3
    .parameter "name"
    .parameter "uid"
    .parameter "userId"
    .parameter "seinfo"

    .prologue
    const/16 v2, 0x20

    .line 435
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "mkuserdata"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 436
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 437
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 438
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 439
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 440
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 441
    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 442
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 443
    if-eqz p4, :cond_0

    .end local p4
    :goto_0
    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 444
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1

    .line 443
    .restart local p4
    :cond_0
    const-string p4, "!"

    goto :goto_0
.end method

.method public deleteCacheFiles(Ljava/lang/String;I)I
    .locals 3
    .parameter "name"
    .parameter "userId"

    .prologue
    const/16 v2, 0x20

    .line 426
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "rmcache"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 427
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 428
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 429
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 430
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 431
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1
.end method

.method public dexopt(Ljava/lang/String;IZ)I
    .locals 3
    .parameter "apkPath"
    .parameter "uid"
    .parameter "isPublic"

    .prologue
    const/16 v2, 0x20

    .line 336
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "dexopt"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 337
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 338
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 339
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 340
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 341
    if-eqz p3, :cond_0

    const-string v1, " 1"

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 342
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1

    .line 341
    :cond_0
    const-string v1, " 0"

    goto :goto_0
.end method

.method protected finalize()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    .line 289
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 290
    iget-object v0, p0, Lcom/android/server/pm/Installer;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Looper;->quit()V

    .line 291
    return-void
.end method

.method public fixUid(Ljava/lang/String;II)I
    .locals 3
    .parameter "name"
    .parameter "uid"
    .parameter "gid"

    .prologue
    const/16 v2, 0x20

    .line 415
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "fixuid"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 416
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 417
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 418
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 419
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 420
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 421
    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 422
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1
.end method

.method public freeCache(J)I
    .locals 2
    .parameter "freeStorageSize"

    .prologue
    .line 472
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "freecache"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 473
    .local v0, builder:Ljava/lang/StringBuilder;
    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 474
    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 475
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1
.end method

.method public getSizeInfo(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/pm/PackageStats;)I
    .locals 7
    .parameter "pkgName"
    .parameter "persona"
    .parameter "apkPath"
    .parameter "libDirPath"
    .parameter "fwdLockApkPath"
    .parameter "asecPath"
    .parameter "pStats"

    .prologue
    const/4 v4, -0x1

    const/16 v6, 0x20

    .line 480
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v5, "getsize"

    invoke-direct {v0, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 481
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 482
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 483
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 484
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 485
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 486
    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 487
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 488
    if-eqz p4, :cond_1

    .end local p4
    :goto_0
    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 489
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 490
    if-eqz p5, :cond_2

    .end local p5
    :goto_1
    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 491
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 492
    if-eqz p6, :cond_3

    .end local p6
    :goto_2
    invoke-virtual {v0, p6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 494
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/server/pm/Installer;->transaction(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 495
    .local v3, s:Ljava/lang/String;
    const-string v5, " "

    invoke-virtual {v3, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 497
    .local v2, res:[Ljava/lang/String;
    if-eqz v2, :cond_0

    array-length v5, v2

    const/4 v6, 0x5

    if-eq v5, v6, :cond_4

    .line 507
    :cond_0
    :goto_3
    return v4

    .line 488
    .end local v2           #res:[Ljava/lang/String;
    .end local v3           #s:Ljava/lang/String;
    .restart local p4
    .restart local p5
    .restart local p6
    :cond_1
    const-string p4, "!"

    goto :goto_0

    .line 490
    .end local p4
    :cond_2
    const-string p5, "!"

    goto :goto_1

    .line 492
    .end local p5
    :cond_3
    const-string p6, "!"

    goto :goto_2

    .line 501
    .end local p6
    .restart local v2       #res:[Ljava/lang/String;
    .restart local v3       #s:Ljava/lang/String;
    :cond_4
    const/4 v5, 0x1

    :try_start_0
    aget-object v5, v2, v5

    invoke-static {v5}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v5

    iput-wide v5, p7, Landroid/content/pm/PackageStats;->codeSize:J

    .line 502
    const/4 v5, 0x2

    aget-object v5, v2, v5

    invoke-static {v5}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v5

    iput-wide v5, p7, Landroid/content/pm/PackageStats;->dataSize:J

    .line 503
    const/4 v5, 0x3

    aget-object v5, v2, v5

    invoke-static {v5}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v5

    iput-wide v5, p7, Landroid/content/pm/PackageStats;->cacheSize:J

    .line 504
    const/4 v5, 0x4

    aget-object v5, v2, v5

    invoke-static {v5}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v5

    iput-wide v5, p7, Landroid/content/pm/PackageStats;->externalCodeSize:J

    .line 505
    const/4 v5, 0x0

    aget-object v5, v2, v5

    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v4

    goto :goto_3

    .line 506
    :catch_0
    move-exception v1

    .line 507
    .local v1, e:Ljava/lang/NumberFormatException;
    goto :goto_3
.end method

.method public idmap(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;III)I
    .locals 3
    .parameter "targetApkPath"
    .parameter "overlayApkPath"
    .parameter "redirectionsPath"
    .parameter "uid"
    .parameter "targetHash"
    .parameter "overlayHash"

    .prologue
    const/16 v2, 0x20

    .line 347
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "idmap"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 348
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 349
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 350
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 351
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 352
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 353
    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 354
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 355
    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 356
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 357
    invoke-virtual {v0, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 358
    if-eqz p3, :cond_0

    .line 359
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 360
    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 362
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1
.end method

.method public install(Ljava/lang/String;IILjava/lang/String;)I
    .locals 3
    .parameter "name"
    .parameter "uid"
    .parameter "gid"
    .parameter "seinfo"

    .prologue
    const/16 v2, 0x20

    .line 323
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "install"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 324
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 325
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 326
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 327
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 328
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 329
    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 330
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 331
    if-eqz p4, :cond_0

    .end local p4
    :goto_0
    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 332
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1

    .line 331
    .restart local p4
    :cond_0
    const-string p4, "!"

    goto :goto_0
.end method

.method public linkNativeLibraryDirectory(Ljava/lang/String;Ljava/lang/String;I)I
    .locals 4
    .parameter "dataPath"
    .parameter "nativeLibPath"
    .parameter "userId"

    .prologue
    const/16 v2, 0x20

    const/4 v1, -0x1

    .line 524
    if-nez p1, :cond_0

    .line 525
    const-string v2, "Installer"

    const-string v3, "linkNativeLibraryDirectory dataPath is null"

    invoke-static {v2, v3}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 539
    :goto_0
    return v1

    .line 527
    :cond_0
    if-nez p2, :cond_1

    .line 528
    const-string v2, "Installer"

    const-string v3, "linkNativeLibraryDirectory nativeLibPath is null"

    invoke-static {v2, v3}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 532
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "linklib "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 533
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 534
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 535
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 536
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 537
    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 539
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    goto :goto_0
.end method

.method public moveFiles()I
    .locals 1

    .prologue
    .line 512
    const-string v0, "movefiles"

    invoke-direct {p0, v0}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public movedex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 3
    .parameter "srcPath"
    .parameter "dstPath"

    .prologue
    const/16 v2, 0x20

    .line 381
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "movedex"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 382
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 383
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 384
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 385
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 386
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1
.end method

.method public ping()Z
    .locals 1

    .prologue
    .line 464
    const-string v0, "ping"

    invoke-direct {p0, v0}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v0

    if-gez v0, :cond_0

    .line 465
    const/4 v0, 0x0

    .line 467
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public remove(Ljava/lang/String;I)I
    .locals 3
    .parameter "name"
    .parameter "userId"

    .prologue
    const/16 v2, 0x20

    .line 397
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "remove"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 398
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 399
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 400
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 401
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 402
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1
.end method

.method public removeUserDataDirs(I)I
    .locals 2
    .parameter "userId"

    .prologue
    .line 448
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "rmuser"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 449
    .local v0, builder:Ljava/lang/StringBuilder;
    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 450
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 451
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1
.end method

.method public rename(Ljava/lang/String;Ljava/lang/String;)I
    .locals 3
    .parameter "oldname"
    .parameter "newname"

    .prologue
    const/16 v2, 0x20

    .line 406
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "rename"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 407
    .local v0, builder:Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 408
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 409
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 410
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 411
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1
.end method

.method public restoreconData()Z
    .locals 1

    .prologue
    .line 543
    const-string v0, "restorecondata"

    invoke-direct {p0, v0}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public rmdex(Ljava/lang/String;)I
    .locals 2
    .parameter "codePath"

    .prologue
    .line 390
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "rmdex"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 391
    .local v0, builder:Ljava/lang/StringBuilder;
    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 392
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 393
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/server/pm/Installer;->execute(Ljava/lang/String;)I

    move-result v1

    return v1
.end method
