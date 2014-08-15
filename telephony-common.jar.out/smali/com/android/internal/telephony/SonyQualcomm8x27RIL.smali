.class public Lcom/android/internal/telephony/SonyQualcomm8x27RIL;
.super Lcom/android/internal/telephony/RIL;
.source "SonyQualcomm8x27RIL.java"

# interfaces
.implements Lcom/android/internal/telephony/CommandsInterface;


# direct methods
.method public constructor <init>(Landroid/content/Context;II)V
    .locals 1
    .parameter "context"
    .parameter "networkMode"
    .parameter "cdmaSubscription"

    .prologue
    .line 28
    invoke-direct {p0, p1, p2, p3}, Lcom/android/internal/telephony/RIL;-><init>(Landroid/content/Context;II)V

    .line 30
    const/4 v0, 0x5

    iput v0, p0, Lcom/android/internal/telephony/SonyQualcomm8x27RIL;->mQANElements:I

    .line 31
    return-void
.end method
