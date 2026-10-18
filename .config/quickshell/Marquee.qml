// Marquee.qml — shared MPRIS + marquee state (one ticker for all screens)
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Scope {
    id: root

    // The player that last played, so the widget sticks to it when paused
    property var lastPlayer: null

    // A playing player wins; otherwise keep the one that last played, then any
    // player that actually has a track. Idle players with no track (e.g. a
    // browser that reports "Stopped") never take the widget over.
    readonly property var player: {
        const ps = Mpris.players.values;
        const playing = ps.find(p => p.isPlaying);
        if (playing) return playing;
        if (lastPlayer && ps.indexOf(lastPlayer) >= 0 && lastPlayer.trackTitle) return lastPlayer;
        return ps.find(p => p.trackTitle) ?? null;
    }
    readonly property bool playing: player !== null && player.isPlaying
    onPlayingChanged: if (playing) lastPlayer = player
    readonly property string title: player
        ? ((player.trackArtist ? player.trackArtist + " - " : "") + player.trackTitle)
        : ""
    // nf-md pause (while playing) / play (while paused)
    readonly property string text: (playing ? "\uDB80\uDFE4 " : "\uDB81\uDC0A ") + title

    readonly property int maxW: 150       // visible width in px
    readonly property int gap: 20         // gap between the two copies
    readonly property int step: 1         // px per tick (integer = crisp text)
    readonly property int interval: 33    // ms per tick (~30 fps); 50 = 20 fps
    readonly property int holdMs: 2500    // idle pause at the start of each loop

    readonly property real textW: measure.implicitWidth
    readonly property bool animating: playing && textW > maxW

    property int x: 0
    property bool hold: true

    // Invisible text, only used to measure the width
    Item {
        visible: false
        Text {
            id: measure
            text: root.text
            font.family: Theme.iconFont
            font.pixelSize: 11
        }
    }

    onAnimatingChanged: { x = 0; hold = true; }
    onTitleChanged: { x = 0; hold = true; }

    // Runs whenever we are scrolling-capable AND holding at the start.
    Timer {
        interval: root.holdMs
        repeat: false
        running: root.animating && root.hold
        onTriggered: root.hold = false
    }

    // Runs only while text actually scrolls; otherwise zero repaints.
    Timer {
        interval: root.interval
        repeat: true
        running: root.animating && !root.hold
        onTriggered: {
            root.x -= root.step;
            if (root.x <= -(root.textW + root.gap)) {
                root.x = 0;
                root.hold = true;
            }
        }
    }
}