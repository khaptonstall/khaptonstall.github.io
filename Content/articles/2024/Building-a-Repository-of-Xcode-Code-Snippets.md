---
author: Kyle Haptonstall
date: 2024-04-22 11:38
tags: Developer Tools
---
# Building a Repository of Xcode Code Snippets

This post will outline a process of checking Xcode Code Snippets into source control in order to build out a library of snippets you can easily import on new machines or take with you to new companies. (You can also use this to create a shared library of snippets within a development team.)

I won’t go over how to create and use code snippets *within* Xcode, but if you’d like a refresher, check out [this post by Sarun](https://sarunw.com/posts/how-to-create-code-snippets-in-xcode/).

# Setup

## Create a code snippets repository

First, you’ll need to have a repository setup in which you’ll store your code snippets. We’ll assume that’s done and that we’ll store all snippets within the root of that repository.

## Save your first snippet

We’ll also need a code snippet to work with. For demo purposes, I’ll use the one below, which contains some boilerplate to create a new `EnvironmentKey` in SwiftUI:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>IDECodeSnippetCompletionPrefix</key>
	<string>environmentkey</string>
	<key>IDECodeSnippetCompletionScopes</key>
	<array>
		<string>TopLevel</string>
	</array>
	<key>IDECodeSnippetContents</key>
	<string>private struct &lt;#Key#&gt;: EnvironmentKey {
    static let defaultValue: &lt;#Type#&gt; = &lt;#Default Value#&gt;
}

extension EnvironmentValues {
    var &lt;#name#&gt;: &lt;#Type#&gt; {
        get { self[&lt;#Key#&gt;.self] }
        set { self[&lt;#Key#&gt;.self] = newValue }
    }
}</string>
	<key>IDECodeSnippetIdentifier</key>
	<string>8DBC6F81-7661-48B5-B852-2336988AB94C</string>
	<key>IDECodeSnippetLanguage</key>
	<string>Xcode.SourceCodeLanguage.Swift</string>
	<key>IDECodeSnippetSummary</key>
	<string></string>
	<key>IDECodeSnippetTitle</key>
	<string>EnvironmentKey</string>
	<key>IDECodeSnippetUserSnippet</key>
	<true/>
	<key>IDECodeSnippetVersion</key>
	<integer>0</integer>
</dict>
</plist>
```

And here’s the Swift code the above code snippet will generate:

```swift
private struct <#Key#>: EnvironmentKey {
    static let defaultValue: <#Type#> = <#Default Value#>
}

extension EnvironmentValues {
    var <#name#>: <#Type#> {
        get { self[<#Key#>.self] }
        set { self[<#Key#>.self] = newValue }
    }
}
```

Copy the XML code snippet from above and save it as a new file within the root directory of your repo with the extension `.codesnippet` (e.g. `environment-key.codesnippet`).

# Load Your Custom Code Snippets

To make your code snippets available to Xcode, you’ll need to move them into the `CodeSnippets` directory, found at `~/Library/Developer/Xcode/UserData/CodeSnippets`.

Below is a script you can create and store in your code snippets repo to help automate the process:

```shell
#!/bin/bash

# Store the Xcode CodeSnippets directory into a variable we can reference
SNIPPETS_DIRECTORY="$HOME/Library/Developer/Xcode/UserData/CodeSnippets"

# Find all .codesnippet files within the current directory and 
# store them in a variable
SNIPPETS=$(find ./ -type f -name '*.codesnippet')

# For each .codesnippet file, copy it into the snippets directory
echo "$SNIPPETS" | xargs -I {} cp {} $SNIPPETS_DIRECTORY
```

As you continue working in Xcode and find yourself typing the same boilerplate, you can create Xcode Code Snippets and pull them from the CodeSnippets directory into your own repo. Then, when you jump to a new machine, simply clone your repo and run the script above! 🎉

There’s also opportunity here to create a script which does the reverse (i.e. pulls all the snippets *out* of the CodeSnippets directory and into your repo), but I’ll leave that as an exercise to the reader 🧑‍💻.



