package main

import "core:fmt"
import "core:time"
import "vendor:sdl2"
import sdl2image "vendor:sdl2/image"

ThoughtType :: enum {
    Empty,
    Shelter,
    Transport,
    Energy,
    Support,
    Tech,
    Education,
    Joy,
}

ShelterFlag :: enum u8 {
    Nest,
    Den, 
    Village,

    Small,
    Medium,
    Large,

    Higround,
    Lowground
}

ShelterFlags :: bit_set[ShelterFlag]

TransportFlag :: enum u8 {
    CanWalk,
    CanRun,
    CanSwim,
    CanFly,
    CanShift,
    CanLevitate,
    CanTunnel
}

TransportFlags :: bit_set[TransportFlag]

EnergyFlag :: enum u16 {
    isSpicy,
    isSweet,
    isSour,
    isSavory,
    isBitter,
    isMoist,
    isDry,

    isCharge,
    isHeat,
    isCold,
    isLight,
    isDark
}

EnergyFlags :: bit_set[EnergyFlag]

SupportFlag :: enum u8 {
    Hunter,
    Gather,
    Collect,
    Trade,
    Clean,
    Cook
}

SupportFlags :: bit_set[SupportFlag]

TechnoFlag :: enum u16 {
    Burn,
    Build,
    Smash,
    Push,
    Water,
    Fly,
    Cut,
    Detox,
    Activate,
    Dig,
    Scan,
    Freeze
}

TechnoFlags :: bit_set[TechnoFlag]

EducateFlag :: enum u16 {
    Study,
    Train,
    Watch,
    Meditate,
    Recall,
    Practice,
    Research,
    Write,
    Tune
}

EducateFlags :: bit_set[EducateFlag]

JoyFlag :: enum u8 {
    TV,
    Book,
    Paint,
    Sculpt,
    Sport,
    Music
}

JoyFlags :: bit_set[JoyFlag]

Thoughts :: struct {
    think_type: ThoughtType,
    shelter: ShelterFlags,
    transpo: TransportFlags,
    flavor: EnergyFlags, 
    support: SupportFlags,
    mechanic: TechnoFlags,
    knowledge: EducateFlags,
    joy: JoyFlags,
}

