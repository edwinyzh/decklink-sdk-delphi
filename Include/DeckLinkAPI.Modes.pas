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

unit DeckLinkAPI.Modes;

{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses
  System.SysUtils, System.Variants, Winapi.ActiveX;

const
  IID_IDeckLinkDisplayModeIterator: TGUID = '{9C88499F-F601-4021-B80B-032E4EB41C35}';
  IID_IDeckLinkDisplayMode: TGUID = '{3EB2C1AB-0A3D-4523-A3AD-F40D7FB14E78}';
  
// Type Declarations


// Enumeration Mapping


(* Enum BMDDisplayMode - Video display modes *)
type
  _BMDDisplayMode = TOleEnum;
const
    (* SD Modes *)
    bmdModeNTSC                                                  = (* 'ntsc' *) $6E747363;
    bmdModeNTSC2398                                              = (* 'nt23' *) $6E743233;	// 3:2 pulldown
    bmdModePAL                                                   = (* 'pal ' *) $70616C20;
    bmdModeNTSCp                                                 = (* 'ntsp' *) $6E747370;
    bmdModePALp                                                  = (* 'palp' *) $70616C70;
    (* HD 1080 Modes *)
    bmdModeHD1080p2398                                           = (* '23ps' *) $32337073;
    bmdModeHD1080p24                                             = (* '24ps' *) $32347073;
    bmdModeHD1080p25                                             = (* 'Hp25' *) $48703235;
    bmdModeHD1080p2997                                           = (* 'Hp29' *) $48703239;
    bmdModeHD1080p30                                             = (* 'Hp30' *) $48703330;
    bmdModeHD1080i50                                             = (* 'Hi50' *) $48693530;
    bmdModeHD1080i5994                                           = (* 'Hi59' *) $48693539;
    bmdModeHD1080i6000                                           = (* 'Hi60' *) $48693630;	// N.B. This _really_ is 60.00 Hz.
    bmdModeHD1080p50                                             = (* 'Hp50' *) $48703530;
    bmdModeHD1080p5994                                           = (* 'Hp59' *) $48703539;
    bmdModeHD1080p6000                                           = (* 'Hp60' *) $48703630;	// N.B. This _really_ is 60.00 Hz.
    (* HD 720 Modes *)
    bmdModeHD720p50                                              = (* 'hp50' *) $68703530;
    bmdModeHD720p5994                                            = (* 'hp59' *) $68703539;
    bmdModeHD720p60                                              = (* 'hp60' *) $68703630;
    (* 2k Modes *)
    bmdMode2k2398                                                = (* '2k23' *) $326B3233;
    bmdMode2k24                                                  = (* '2k24' *) $326B3234;
    bmdMode2k25                                                  = (* '2k25' *) $326B3235;
    (* DCI Modes (output only) *)
    bmdMode2kDCI2398                                             = (* '2d23' *) $32643233;
    bmdMode2kDCI24                                               = (* '2d24' *) $32643234;
    bmdMode2kDCI25                                               = (* '2d25' *) $32643235;
    (* 4k Modes *)
    bmdMode4K2160p2398                                           = (* '4k23' *) $346B3233;
    bmdMode4K2160p24                                             = (* '4k24' *) $346B3234;
    bmdMode4K2160p25                                             = (* '4k25' *) $346B3235;
    bmdMode4K2160p2997                                           = (* '4k29' *) $346B3239;
    bmdMode4K2160p30                                             = (* '4k30' *) $346B3330;
    bmdMode4K2160p50                                             = (* '4k50' *) $346B3530;
    bmdMode4K2160p5994                                           = (* '4k59' *) $346B3539;
    bmdMode4K2160p60                                             = (* '4k60' *) $346B3630;
    (* DCI Modes (output only) *)
    bmdMode4kDCI2398                                             = (* '4d23' *) $34643233;
    bmdMode4kDCI24                                               = (* '4d24' *) $34643234;
    bmdMode4kDCI25                                               = (* '4d25' *) $34643235;
    (* Special Modes *)
    bmdModeUnknown                                               = (* 'iunk' *) $69756E6B;

(* Enum BMDFieldDominance - Video field dominance *)
type
  _BMDFieldDominance = TOleEnum;
const
    bmdUnknownFieldDominance                                     = 0;
    bmdLowerFieldFirst                                           = (* 'lowr' *) $6C6F7772;
    bmdUpperFieldFirst                                           = (* 'uppr' *) $75707072;
    bmdProgressiveFrame                                          = (* 'prog' *) $70726F67;
    bmdProgressiveSegmentedFrame                                 = (* 'psf ' *) $70736620;


(* Enum BMDPixelFormat - Video pixel formats supported for output/input *)
type
  _BMDPixelFormat = TOleEnum;
const
    bmdFormat8BitYUV                                             = (* '2vuy' *) $32767579;
    bmdFormat10BitYUV                                            = (* 'v210' *) $76323130;
    bmdFormat8BitARGB                                            = 32;
    bmdFormat8BitBGRA                                            = (* 'BGRA' *) $42475241;
    bmdFormat10BitRGB                                            = (* 'r210' *) $72323130;	// Big-endian RGB 10-bit per component with SMPTE video levels (64-960). Packed as 2:10:10:10
    bmdFormat12BitRGB                                            = (* 'R12B' *) $52313242;	// Big-endian RGB 12-bit per component with full range (0-4095). Packed as 12-bit per component
    bmdFormat12BitRGBLE                                          = (* 'R12L' *) $5231324C;	// Little-endian RGB 12-bit per component with full range (0-4095). Packed as 12-bit per component
    bmdFormat10BitRGBXLE                                         = (* 'R10l' *) $5231306C;	// Little-endian 10-bit RGB with SMPTE video levels (64-940)
    bmdFormat10BitRGBX                                           = (* 'R10b' *) $52313062;	// Big-endian 10-bit RGB with SMPTE video levels (64-940)
    bmdFormatH265                                                = (* 'hev1' *) $68657631;	// High Efficiency Video Coding (HEVC/h.265)
    (* AVID DNxHR *)
    bmdFormatDNxHR                                               = (* 'AVdh' *) $41566468;


(* Enum BMDDisplayModeFlags - Flags to describe the characteristics of an IDeckLinkDisplayMode. *)
type
  _BMDDisplayModeFlags = TOleEnum;
const
    bmdDisplayModeSupports3D                                     = 1 shl 0;
    bmdDisplayModeColorspaceRec601                               = 1 shl 1;
    bmdDisplayModeColorspaceRec709                               = 1 shl 2;

// Forward Declarations
type  
	IDeckLinkDisplayModeIterator = interface;
	IDeckLinkDisplayMode = interface;

(* Interface IDeckLinkDisplayModeIterator - enumerates over supported input/output display modes. *)
// *********************************************************************//
// Interface: IDeckLinkDisplayModeIterator
// Flags:     (0)
// GUID:      {9C88499F-F601-4021-B80B-032E4EB41C35}
// *********************************************************************//
  IDeckLinkDisplayModeIterator = interface(IUnknown)
    ['{9C88499F-F601-4021-B80B-032E4EB41C35}']
    function Next(out deckLinkDisplayMode: IDeckLinkDisplayMode): HResult; stdcall;
  end;

(* Interface IDeckLinkDisplayMode - represents a display mode *)
// *********************************************************************//
// Interface: IDeckLinkDisplayMode
// Flags:     (0)
// GUID:      {3EB2C1AB-0A3D-4523-A3AD-F40D7FB14E78}
// *********************************************************************//
  IDeckLinkDisplayMode = interface(IUnknown)
    ['{3EB2C1AB-0A3D-4523-A3AD-F40D7FB14E78}']
    function GetName(out name: WideString): HResult; stdcall;
    function GetDisplayMode: _BMDDisplayMode; stdcall;
    function GetWidth: Integer; stdcall;
    function GetHeight: Integer; stdcall;
    function GetFrameRate(out frameDuration: Int64; out timeScale: Int64): HResult; stdcall;
    function GetFieldDominance: _BMDFieldDominance; stdcall;
    function GetFlags: _BMDDisplayModeFlags; stdcall;
  end;

(* Coclasses *)

implementation

end.