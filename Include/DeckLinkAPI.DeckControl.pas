(* -LICENSE-START-
** Copyright (c) 2016 Blackmagic Design
**
** Permission is hereby granted; free of charge; to any person or organization
** obtaining a copy of the software and accompanying documentation covered by
** this license (the "Software") to use; reproduce; display; distribute;
** execute; and transmit the Software; and to prepare derivative works of the
** Software; and to permit third-parties to whom the Software is furnished to
** do so; all subject to the following:
** 
** The copyright notices in the Software and this entire statement; including
** the above license grant; this restriction and the following disclaimer;
** must be included in all copies of the Software; in whole or in part; and
** all derivative works of the Software; unless such copies or derivative
** works are solely in the form of machine-executable object code generated by
** a source language processor.
** 
** THE SOFTWARE IS PROVIDED "AS IS"; WITHOUT WARRANTY OF ANY KIND; EXPRESS OR
** IMPLIED; INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY;
** FITNESS FOR A PARTICULAR PURPOSE; TITLE AND NON-INFRINGEMENT. IN NO EVENT
** SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
** FOR ANY DAMAGES OR OTHER LIABILITY; WHETHER IN CONTRACT; TORT OR OTHERWISE;
** ARISING FROM; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
** DEALINGS IN THE SOFTWARE.
** -LICENSE-END-
*)

unit DeckLinkAPI.DeckControl;

{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses
  System.SysUtils, System.Variants, Winapi.ActiveX,
  DeckLinkAPI.Types;

const
  IID_IDeckLinkDeckControlStatusCallback: TGUID = '{53436FFB-B434-4906-BADC-AE3060FFE8EF}';
  IID_IDeckLinkDeckControl: TGUID = '{8E1C3ACE-19C7-4E00-8B92-D80431D958BE}';
  
// Type Declarations


// Enumeration Mapping

(* Enum BMDDeckControlMode - DeckControl mode *)
type
  _BMDDeckControlMode = TOleEnum;
const
    bmdDeckControlNotOpened                                      = (* 'ntop' *) $6E746F70;
    bmdDeckControlVTRControlMode                                 = (* 'vtrc' *) $76747263;
    bmdDeckControlExportMode                                     = (* 'expm' *) $6578706D;
    bmdDeckControlCaptureMode                                    = (* 'capm' *) $6361706D;

(* Enum BMDDeckControlEvent - DeckControl event *)
type
  _BMDDeckControlEvent = TOleEnum;
const
    bmdDeckControlAbortedEvent                                   = (* 'abte' *) $61627465;	// This event is triggered when a capture or edit-to-tape operation is aborted.

    (* Export-To-Tape events *)

    bmdDeckControlPrepareForExportEvent                          = (* 'pfee' *) $70666565;	// This event is triggered a few frames before reaching the in-point. IDeckLinkInput::StartScheduledPlayback() should be called at this point.
    bmdDeckControlExportCompleteEvent                            = (* 'exce' *) $65786365;	// This event is triggered a few frames after reaching the out-point. At this point; it is safe to stop playback.

    (* Capture events *)

    bmdDeckControlPrepareForCaptureEvent                         = (* 'pfce' *) $70666365;	// This event is triggered a few frames before reaching the in-point. The serial timecode attached to IDeckLinkVideoInputFrames is now valid.
    bmdDeckControlCaptureCompleteEvent                           = (* 'ccev' *) $63636576;	// This event is triggered a few frames after reaching the out-point.

(* Enum BMDDeckControlVTRControlState - VTR Control state *)
type
  _BMDDeckControlVTRControlState = TOleEnum;
const
    bmdDeckControlNotInVTRControlMode                            = (* 'nvcm' *) $6E76636D;
    bmdDeckControlVTRControlPlaying                              = (* 'vtrp' *) $76747270;
    bmdDeckControlVTRControlRecording                            = (* 'vtrr' *) $76747272;
    bmdDeckControlVTRControlStill                                = (* 'vtra' *) $76747261;
    bmdDeckControlVTRControlShuttleForward                       = (* 'vtsf' *) $76747366;
    bmdDeckControlVTRControlShuttleReverse                       = (* 'vtsr' *) $76747372;
    bmdDeckControlVTRControlJogForward                           = (* 'vtjf' *) $76746A66;
    bmdDeckControlVTRControlJogReverse                           = (* 'vtjr' *) $76746A72;
    bmdDeckControlVTRControlStopped                              = (* 'vtro' *) $7674726F;

(* Enum BMDDeckControlStatusFlags - Deck Control status flags *)
type
  _BMDDeckControlStatusFlags = TOleEnum;
const
    bmdDeckControlStatusDeckConnected                            = 1 shl 0;
    bmdDeckControlStatusRemoteMode                               = 1 shl 1;
    bmdDeckControlStatusRecordInhibited                          = 1 shl 2;
    bmdDeckControlStatusCassetteOut                              = 1 shl 3;

(* Enum BMDDeckControlExportModeOpsFlags - Export mode flags *)
type
  _BMDDeckControlExportModeOpsFlags = TOleEnum;
const
    bmdDeckControlExportModeInsertVideo                          = 1 shl 0;
    bmdDeckControlExportModeInsertAudio1                         = 1 shl 1;
    bmdDeckControlExportModeInsertAudio2                         = 1 shl 2;
    bmdDeckControlExportModeInsertAudio3                         = 1 shl 3;
    bmdDeckControlExportModeInsertAudio4                         = 1 shl 4;
    bmdDeckControlExportModeInsertAudio5                         = 1 shl 5;
    bmdDeckControlExportModeInsertAudio6                         = 1 shl 6;
    bmdDeckControlExportModeInsertAudio7                         = 1 shl 7;
    bmdDeckControlExportModeInsertAudio8                         = 1 shl 8;
    bmdDeckControlExportModeInsertAudio9                         = 1 shl 9;
    bmdDeckControlExportModeInsertAudio10                        = 1 shl 10;
    bmdDeckControlExportModeInsertAudio11                        = 1 shl 11;
    bmdDeckControlExportModeInsertAudio12                        = 1 shl 12;
    bmdDeckControlExportModeInsertTimeCode                       = 1 shl 13;
    bmdDeckControlExportModeInsertAssemble                       = 1 shl 14;
    bmdDeckControlExportModeInsertPreview                        = 1 shl 15;
    bmdDeckControlUseManualExport                                = 1 shl 16;

(* Enum BMDDeckControlError - Deck Control error *)
type
  _BMDDeckControlError = TOleEnum;
const
    bmdDeckControlNoError                                        = (* 'noer' *) $6E6F6572;
    bmdDeckControlModeError                                      = (* 'moer' *) $6D6F6572;
    bmdDeckControlMissedInPointError                             = (* 'mier' *) $6D696572;
    bmdDeckControlDeckTimeoutError                               = (* 'dter' *) $64746572;
    bmdDeckControlCommandFailedError                             = (* 'cfer' *) $63666572;
    bmdDeckControlDeviceAlreadyOpenedError                       = (* 'dalo' *) $64616C6F;
    bmdDeckControlFailedToOpenDeviceError                        = (* 'fder' *) $66646572;
    bmdDeckControlInLocalModeError                               = (* 'lmer' *) $6C6D6572;
    bmdDeckControlEndOfTapeError                                 = (* 'eter' *) $65746572;
    bmdDeckControlUserAbortError                                 = (* 'uaer' *) $75616572;
    bmdDeckControlNoTapeInDeckError                              = (* 'nter' *) $6E746572;
    bmdDeckControlNoVideoFromCardError                           = (* 'nvfc' *) $6E766663;
    bmdDeckControlNoCommunicationError                           = (* 'ncom' *) $6E636F6D;
    bmdDeckControlBufferTooSmallError                            = (* 'btsm' *) $6274736D;
    bmdDeckControlBadChecksumError                               = (* 'chks' *) $63686B73;
    bmdDeckControlUnknownError                                   = (* 'uner' *) $756E6572;

// Forward Declarations
type
  IDeckLinkDeckControlStatusCallback = interface;
  IDeckLinkDeckControl = interface;

  
// *********************************************************************//
// Interface: IDeckLinkDeckControlStatusCallback
// Flags:     (0)
// GUID:      {53436FFB-B434-4906-BADC-AE3060FFE8EF}
// *********************************************************************//
  IDeckLinkDeckControlStatusCallback = interface(IUnknown)
    ['{53436FFB-B434-4906-BADC-AE3060FFE8EF}']
    function TimecodeUpdate(currentTimecode: SYSUINT): HResult; stdcall;
    function VTRControlStateChanged(newState: _BMDDeckControlVTRControlState; 
                                    error: _BMDDeckControlError): HResult; stdcall;
    function DeckControlEventReceived(event: _BMDDeckControlEvent; error: _BMDDeckControlError): HResult; stdcall;
    function DeckControlStatusChanged(flags: _BMDDeckControlStatusFlags; mask: SYSUINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDeckLinkDeckControl
// Flags:     (0)
// GUID:      {8E1C3ACE-19C7-4E00-8B92-D80431D958BE}
// *********************************************************************//
  IDeckLinkDeckControl = interface(IUnknown)
    ['{8E1C3ACE-19C7-4E00-8B92-D80431D958BE}']
    function Open(timeScale: Int64; timeValue: Int64; timecodeIsDropFrame: Integer; 
                  out error: _BMDDeckControlError): HResult; stdcall;
    function Close(standbyOn: Integer): HResult; stdcall;
    function GetCurrentState(out mode: _BMDDeckControlMode; 
                             out vtrControlState: _BMDDeckControlVTRControlState; 
                             out flags: _BMDDeckControlStatusFlags): HResult; stdcall;
    function SetStandby(standbyOn: Integer): HResult; stdcall;
    function SendCommand(var inBuffer: Byte; inBufferSize: SYSUINT; out outBuffer: Byte; 
                         out outDataSize: SYSUINT; outBufferSize: SYSUINT; 
                         out error: _BMDDeckControlError): HResult; stdcall;
    function Play(out error: _BMDDeckControlError): HResult; stdcall;
    function Stop(out error: _BMDDeckControlError): HResult; stdcall;
    function TogglePlayStop(out error: _BMDDeckControlError): HResult; stdcall;
    function Eject(out error: _BMDDeckControlError): HResult; stdcall;
    function GoToTimecode(timecode: SYSUINT; out error: _BMDDeckControlError): HResult; stdcall;
    function FastForward(viewTape: Integer; out error: _BMDDeckControlError): HResult; stdcall;
    function Rewind(viewTape: Integer; out error: _BMDDeckControlError): HResult; stdcall;
    function StepForward(out error: _BMDDeckControlError): HResult; stdcall;
    function StepBack(out error: _BMDDeckControlError): HResult; stdcall;
    function Jog(rate: Double; out error: _BMDDeckControlError): HResult; stdcall;
    function Shuttle(rate: Double; out error: _BMDDeckControlError): HResult; stdcall;
    function GetTimecodeString(out currentTimecode: WideString; out error: _BMDDeckControlError): HResult; stdcall;
    function GetTimecode(out currentTimecode: IDeckLinkTimecode; out error: _BMDDeckControlError): HResult; stdcall;
    function GetTimecodeBCD(out currentTimecode: SYSUINT; out error: _BMDDeckControlError): HResult; stdcall;
    function SetPreroll(prerollSeconds: SYSUINT): HResult; stdcall;
    function GetPreroll(out prerollSeconds: SYSUINT): HResult; stdcall;
    function SetExportOffset(exportOffsetFields: SYSINT): HResult; stdcall;
    function GetExportOffset(out exportOffsetFields: SYSINT): HResult; stdcall;
    function GetManualExportOffset(out deckManualExportOffsetFields: SYSINT): HResult; stdcall;
    function SetCaptureOffset(captureOffsetFields: SYSINT): HResult; stdcall;
    function GetCaptureOffset(out captureOffsetFields: SYSINT): HResult; stdcall;
    function StartExport(inTimecode: SYSUINT; outTimecode: SYSUINT; 
                         exportModeOps: _BMDDeckControlExportModeOpsFlags; 
                         out error: _BMDDeckControlError): HResult; stdcall;
    function StartCapture(useVITC: Integer; inTimecode: SYSUINT; outTimecode: SYSUINT; 
                          out error: _BMDDeckControlError): HResult; stdcall;
    function GetDeviceID(out deviceId: Word; out error: _BMDDeckControlError): HResult; stdcall;
    function Abort: HResult; stdcall;
    function CrashRecordStart(out error: _BMDDeckControlError): HResult; stdcall;
    function CrashRecordStop(out error: _BMDDeckControlError): HResult; stdcall;
    function SetCallback(const callback: IDeckLinkDeckControlStatusCallback): HResult; stdcall;
  end;


(* Coclasses *)

implementation

end.

